# Periodic Table

A command-line program for looking up element information in the `periodic_table`
PostgreSQL database.

## Usage

Make sure PostgreSQL is running and that the `freecodecamp` user can connect to
the `periodic_table` database, then run:

```sh
./element.sh H
./element.sh Hydrogen
./element.sh 1
```

Names and symbols are matched without regard to case. Run `./element.sh` without
an argument for the usage message. Run `./test.sh` to check the lookup behavior
against the database.
