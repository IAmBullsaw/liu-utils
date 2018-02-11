# liu-utils
Some helper scripts for students at LiU

_Working scripts are found in scripts folder_ and _scripts work in progress are found in wip folder_

## person.py
This is a script which can give you information about staff at LiU.

It performs a search for the search terms given, i.e the name of who you want information about.
By default (or if -r is passed) the script performs a second search for where you can visit this employee.

### Example usage
Searching for max 3 results from search term 'foo'
```bash
foo@bar:~$ ./person.py -c 3 foo
Jody Foo
jody.foo@liu.se
+4613282662
jodfo01
E-Huset, Ingång 29C, Rum 3F.482 Campus Valla
Catharina Karlsson Foo
catharina.karlsson.foo@liu.se
+4613282015
catka50
D-Huset, Ingång 31A, Rum 31.310 Campus Valla
Fei Jiao
fei.jiao@liu.se
+4611363349
feiji73
Hus Täppan, rum 6008, Campus Norrköping
```

searching for 'marco kuhlmann'.
Script exits on exact name match

```bash
foo@bar:~$ ./person.py marco kuhlmann
Marco Kuhlmann
marco.kuhlmann@liu.se
+4613284644
marku61
E-Huset, Ingång 27C, Rum 3G.476 Campus Valla
```

only show email and telephone in results

```bash
foo@bar:~$ ./person.py -mt marco kuhlmann
marco.kuhlmann@liu.se
E-Huset, Ingång 27C, Rum 3G.476 Campus Valla
```
