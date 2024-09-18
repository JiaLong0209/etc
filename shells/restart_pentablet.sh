
#!/bin/bash

# Define the process name to search for
PROCESS_NAME="PenTablet"

# Find all PIDs of the pen tablet process
PIDS=$(ps aux | grep $PROCESS_NAME | grep -v grep | awk '{print $2}')

if [ -z "$PIDS" ]; then
    echo "No pen tablet processes found."
else
    echo "Found pen tablet processes with PIDs: \n$PIDS"

    echo "Killing pen tablet processes..."
    for PID in $PIDS; do
        kill $PID
    done

    # Wait for the processes to terminate
    sleep 2

    # Verify if the processes have been killed
    for PID in $PIDS; do
        if kill -0 $PID 2>/dev/null; then
            echo "Process $PID did not terminate. Forcing kill..."
            kill -9 $PID
        else
            echo "Process $PID has been terminated."
        fi
    done
fi

/usr/lib/pentablet/PenTablet.sh
