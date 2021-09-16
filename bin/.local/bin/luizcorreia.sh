#! /bin/sh

# https://github.com/dominictarr/JSON.sh
parse_json() {
    throw() {
        echo "$*" >&2
        exit 1
    }

    BRIEF=0
    LEAFONLY=0
    PRUNE=0
    NO_HEAD=0
    NORMALIZE_SOLIDUS=0

    usage() {
        echo
        echo "Usage: JSON.sh [-b] [-l] [-p] [-s] [-h]"
        echo
        echo "-p - Prune empty. Exclude fields with empty values."
        echo "-l - Leaf only. Only show leaf nodes, which stops data duplication."
        echo "-b - Brief. Combines 'Leaf only' and 'Prune empty' options."
        echo "-n - No-head. Do not show nodes that have no path (lines that start with [])."
        echo "-s - Remove escaping of the solidus symbol (straight slash)."
        echo "-h - This help text."
        echo
    }

    parse_options() {
        set -- "$@"
        local ARGN=$#
        while [ "$ARGN" -ne 0 ]
        do
            case $1 in
                -h) usage
                    exit 0
                    ;;
                -b) BRIEF=1
                    LEAFONLY=1
                    PRUNE=1
                    ;;
                -l) LEAFONLY=1
                    ;;
                -p) PRUNE=1
                    ;;
                -n) NO_HEAD=1
                    ;;
                -s) NORMALIZE_SOLIDUS=1
                    ;;
                ?*) echo "ERROR: Unknown option."
                    usage
                    exit 0
                    ;;
            esac
            shift 1
            ARGN=$((ARGN-1))
        done
    }

    awk_egrep () {
        local pattern_string=$1

        gawk '{
    while ($0) {
      start=match($0, pattern);
      token=substr($0, start, RLENGTH);
      print token;
      $0=substr($0, start+RLENGTH);
    }
  }' pattern="$pattern_string"
    }

    tokenize () {
        local GREP
        local ESCAPE
        local CHAR

        if echo "test string" | egrep -ao --color=never "test" >/dev/null 2>&1
        then
            GREP='egrep -ao --color=never'
        else
            GREP='egrep -ao'
        fi

        if echo "test string" | egrep -o "test" >/dev/null 2>&1
        then
            ESCAPE='(\\[^u[:cntrl:]]|\\u[0-9a-fA-F]{4})'
            CHAR='[^[:cntrl:]"\\]'
        else
            GREP=awk_egrep
            ESCAPE='(\\\\[^u[:cntrl:]]|\\u[0-9a-fA-F]{4})'
            CHAR='[^[:cntrl:]"\\\\]'
        fi

        local STRING="\"$CHAR*($ESCAPE$CHAR*)*\""
        local NUMBER='-?(0|[1-9][0-9]*)([.][0-9]*)?([eE][+-]?[0-9]*)?'
        local KEYWORD='null|false|true'
        local SPACE='[[:space:]]+'

        # Force zsh to expand $A into multiple words
        local is_wordsplit_disabled=$(unsetopt 2>/dev/null | grep -c '^shwordsplit$')
        if [ $is_wordsplit_disabled != 0 ]; then setopt shwordsplit; fi
        $GREP "$STRING|$NUMBER|$KEYWORD|$SPACE|." | egrep -v "^$SPACE$"
        if [ $is_wordsplit_disabled != 0 ]; then unsetopt shwordsplit; fi
    }

    parse_array () {
        local index=0
        local ary=''
        read -r token
        case "$token" in
            ']') ;;
            *)
                while :
                do
                    parse_value "$1" "$index"
                    index=$((index+1))
                    ary="$ary""$value"
                    read -r token
                    case "$token" in
                        ']') break ;;
                        ',') ary="$ary," ;;
                        *) throw "EXPECTED , or ] GOT ${token:-EOF}" ;;
                    esac
                    read -r token
                done
                ;;
        esac
        [ "$BRIEF" -eq 0 ] && value=$(printf '[%s]' "$ary") || value=
        :
    }

    parse_object () {
        local key
        local obj=''
        read -r token
        case "$token" in
            '}') ;;
            *)
                while :
                do
                    case "$token" in
                        '"'*'"') key=$token ;;
                        *) throw "EXPECTED string GOT ${token:-EOF}" ;;
                    esac
                    read -r token
                    case "$token" in
                        ':') ;;
                        *) throw "EXPECTED : GOT ${token:-EOF}" ;;
                    esac
                    read -r token
                    parse_value "$1" "$key"
                    obj="$obj$key:$value"
                    read -r token
                    case "$token" in
                        '}') break ;;
                        ',') obj="$obj," ;;
                        *) throw "EXPECTED , or } GOT ${token:-EOF}" ;;
                    esac
                    read -r token
                done
                ;;
        esac
        [ "$BRIEF" -eq 0 ] && value=$(printf '{%s}' "$obj") || value=
        :
    }

    parse_value () {
        local jpath="${1:+$1,}$2" isleaf=0 isempty=0 print=0
        case "$token" in
            '{') parse_object "$jpath" ;;
            '[') parse_array  "$jpath" ;;
            # At this point, the only valid single-character tokens are digits.
            ''|[!0-9]) throw "EXPECTED value GOT ${token:-EOF}" ;;
            *) value=$token
               # if asked, replace solidus ("\/") in json strings with normalized value: "/"
               [ "$NORMALIZE_SOLIDUS" -eq 1 ] && value=$(echo "$value" | sed 's#\\/#/#g')
               isleaf=1
               [ "$value" = '""' ] && isempty=1
               ;;
        esac
        [ "$value" = '' ] && return
        [ "$NO_HEAD" -eq 1 ] && [ -z "$jpath" ] && return

        [ "$LEAFONLY" -eq 0 ] && [ "$PRUNE" -eq 0 ] && print=1
        [ "$LEAFONLY" -eq 1 ] && [ "$isleaf" -eq 1 ] && [ $PRUNE -eq 0 ] && print=1
        [ "$LEAFONLY" -eq 0 ] && [ "$PRUNE" -eq 1 ] && [ "$isempty" -eq 0 ] && print=1
        [ "$LEAFONLY" -eq 1 ] && [ "$isleaf" -eq 1 ] && \
            [ $PRUNE -eq 1 ] && [ $isempty -eq 0 ] && print=1
        [ "$print" -eq 1 ] && printf "[%s]\t%s\n" "$jpath" "$value"
        :
    }

    parse () {
        read -r token
        parse_value
        read -r token
        case "$token" in
            '') ;;
            *) throw "EXPECTED EOF GOT $token" ;;
        esac
    }

    if ([ "$0" = "$BASH_SOURCE" ] || ! [ -n "$BASH_SOURCE" ]);
    then
        parse_options "$@"
        tokenize | parse
    fi
}


profile=$(curl -s 'http://api.bryangilbert.com/profile')
parsed="$(echo "$profile" | parse_json -l)"

dots() {
    for i in $(seq 1 $1)
    do
        printf "."
        sleep 0.04
    done
}

extract() {
    echo "$parsed" | egrep "\"$1\".*?\"$2\"" | sed -e $'s/.*\t//' -e 's/^"//' -e 's/"$//'
}

EXT_ARRAY=""

bio() {
    extract "bio" "$1"
}

year() {
    seconds=$(echo "$1" | rev | cut -c 4- | rev)
    case "$(uname)" in
        'Darwin') echo "$(date -r $seconds "+%Y")"  ;;
        *)        echo "$(date -d @$seconds "+%Y")" ;;
    esac
}

# Extract and display basic bio information

firstname=$(bio 'firstname')
lastname=$(bio 'lastname')
middlename=$(bio 'middlename')
suffix=$(bio 'suffix')
email=$(bio 'email')
phone=$(bio 'phone')
occupation=$(bio 'title')

printf "\nAccessing Subject Records"
dots 40
printf "\033[92mCOMPLETE\033[0m\n\n"

cat << STOP
  Name:        $firstname $middlename $lastname $suffix
  Occupation:  $occupation
  Email:       $email
  Phone:       $phone
STOP


# Extract and display social accounts (aliases)

printf "\n\nCross Referencing Known Aliases"
dots 34
printf "\033[92mCOMPLETE\033[0m\n\n"

github=$(bio 'githubUsername')
twitter=$(bio 'twitterUsername')
linkedin=$(bio 'linkedinUsername')

cat << STOP
  Github:   $github
  Twitter:  $twitter
  LinkedIn: $linkedin
STOP


# Extract and display education

printf "\n\nAccessing Government Education Records"
dots 27
printf "\033[92mCOMPLETE\033[0m\n\n"

IFS=$'\n'
schools=( $(extract "education" "school") )
degrees=( $(extract "education" "degree") )
majors=( $(extract "education" "major") )
starts=( $(extract "education" "startDate") )
ends=( $(extract "education" "graduatedDate") )

for i in "${!schools[@]}"; do
    startYear=$(year ${starts[i]})
    endYear=$(year ${ends[i]})

    cat << END
  ${schools[i]}
    - Major:  ${majors[i]}
    - Degree: ${degrees[i]}
    - Years:  $startYear - $endYear
END
done


# Extract and display job history

printf "\nLocating Employment Information"
dots 34
printf "\033[92mCOMPLETE\033[0m\n\n"

companies=( $(extract "job" "company") )
titles=( $(extract "positions" "title") )
starts=( $(extract "job" "start") )
ends=( $(extract "job" "end") )

for i in "${!companies[@]}"; do
    startYear=$(year "${starts[i]}")
    if [[ -z "${ends[i]}" ]]
    then
        endYear="Present"
    else
        endYear=$(year "${ends[i]}")
    fi

    cat << END
  ${companies[i]}
    - Role:  ${titles[i]}
    - Years: $startYear - $endYear
END
done


# Extract and display skills

printf "\nEvaluating Technological Proficienies"
dots 28
printf "\033[92mCOMPLETE\033[0m\n\n"

profs=( $(extract "proficiencies" "title") )

for i in "${!profs[@]}"; do
    echo " - ${profs[i]}"
done


# Show link to resume
printf "\n\n******* Analysis Complete *******\n\n"
printf "View Full Report: http://bryangilbert.com/etc/resume\n\n"
printf "Powered By: https://github.com/gilbertw1/personal-api\n\n"
