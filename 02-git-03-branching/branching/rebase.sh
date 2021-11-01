  GNU nano 2.0.6          File: 02-git-03-branching/branching/rebase.sh

#!/bin/bash
# display command line options

count=1
for param in "$@"; do
    echo "Next parameter: $param"
    count=$(( $count + 1 ))
done

echo "====="

