 #!/bin/bash 

./internet.php
source setup_softs.sh

while [ 1 ]; do
	source cpu.sh
	source ram.sh
	source connections.sh
	source tasks.sh
done