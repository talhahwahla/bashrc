alias clip="xclip -selection clipboard"
alias py="python3"
alias pyc="py -c"
alias gss='git status'
alias gds='git diff --staged'

rustrun() {
    file="$1"
    bin="$(basename -s .rs $1)"
    rustc $file && ./${bin}
    rm $bin
}

beep() {
    if [ $# -ne 1 ]; then
        echo "Usage: beep <interval_in_minutes>"
        return 1
    fi

    python - <<END "$1"
import time
import sys
import pyttsx3

def focus_reminder(interval):
    engine = pyttsx3.init()
    while True:
        print("Focus")
        engine.say("Focus")
        engine.runAndWait()
        time.sleep(interval * 60)  # Sleep for interval minutes

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python -c 'import sys; print(\"Usage: beep <interval_in_minutes>\")'")
        sys.exit(1)
 
    try:
        interval = float(sys.argv[1])
        focus_reminder(interval)
    except ValueError:
        print("Interval must be a valid number.")
        sys.exit(1)
END
}

