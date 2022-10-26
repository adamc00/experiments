### ./protected-regex.pl

#### Subject

regex: `\[SEC=(OFFICIAL:\s*Sensitive|PROTECTED|SECRET|TOP-SECRET)`

```
pass (allow):
This is an example subject line [SEC=UNOFFICIAL]

pass (allow):
This is an example subject line [SEC=OFFICIAL]

pass (deny):
This is an example subject line [SEC=OFFICIAL:Sensitive]

pass (deny):
This is an example subject line [SEC=OFFICIAL: Sensitive]

pass (deny):
This is an example subject line [SEC=OFFICIAL:Sensitive, ACCESS=Legal-Privilege]

pass (deny):
This is an example subject line [SEC=OFFICIAL:Sensitive, CAVEAT=SH:NATIONAL-CABINET]

pass (deny):
This is an example subject line [SEC=PROTECTED, EXPIRES=2019-07-01, DOWNTO=OFFICIAL]

pass (deny):
This is an example subject line [SEC=SECRET, CAVEAT=SH:ACCOUNTABLE-MATERIAL, CAVEAT=RI:AUSTEO]

pass (deny):
This is an example subject line [SEC=TOP-SECRET]

```

#### Header

regex: `^X-Protective-Marking:(\n|.)*NS=gov\.au(\n|.)*SEC=(OFFICIAL:\s*Sensitive|PROTECTED|SECRET|TOP-SECRET)`

```
pass (allow):
X-Protective-Marking: VER=2018.4, NS=gov.au,
SEC=UNOFFICIAL,
ORIGIN=neville.jones@entity.gov.au

pass (allow):
X-Protective-Marking: VER=2018.4, NS=gov.au,
SEC=OFFICIAL,
ORIGIN=neville.jones@entity.gov.au

pass (deny):
X-Protective-Marking: VER=2018.4, NS=gov.au,
SEC=OFFICIAL:Sensitive,
ORIGIN=neville.jones@entity.gov.au

pass (deny):
X-Protective-Marking: VER=2018.4, NS=gov.au,
SEC=OFFICIAL: Sensitive,
ORIGIN=neville.jones@entity.gov.au

pass (deny):
X-Protective-Marking: VER=2018.4, NS=gov.au,
SEC=OFFICIAL:Sensitive,
ACCESS=Legal-Privilege,
ORIGIN=neville.jones@entity.gov.au

pass (deny):
X-Protective-Marking: VER=2018.4, NS=gov.au,
SEC=OFFICIAL:Sensitive,
CAVEAT=SH:NATIONAL-CABINET,
ORIGIN=neville.jones@entity.gov.au

pass (deny):
X-Protective-Marking: VER=2018.4, NS=gov.au,
SEC=PROTECTED,
EXPIRES=2019-07-01,
DOWNTO=OFFICIAL,
ORIGIN=neville.jones@entity.gov.au

pass (deny):
X-Protective-Marking: VER=2018.4, NS=gov.au,
SEC=SECRET,
CAVEAT=SH:ACCOUNTABLE-MATERIAL,
CAVEAT=RI:AUSTEO,
ORIGIN=neville.jones@entity.gov.au

pass (deny):
X-Protective-Marking: VER=2018.4, NS=gov.au,
SEC=TOP-SECRET,
ORIGIN=neville.jones@entity.gov.au

```

#### Results

**Failures: 0**

