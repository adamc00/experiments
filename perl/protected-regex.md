### ./protected-regex.pl

#### Subject

regex: `\[SEC=(OFFICIAL:\s*Sensitive|PROTECTED|SECRET|TOP-SECRET)`

```
pass:	This is an example subject line [SEC=UNOFFICIAL] (allow)

pass:	This is an example subject line [SEC=OFFICIAL] (allow)

pass:	This is an example subject line [SEC=OFFICIAL:Sensitive] (deny)

pass:	This is an example subject line [SEC=OFFICIAL: Sensitive] (deny)

pass:	This is an example subject line [SEC=OFFICIAL:Sensitive, ACCESS=Legal-Privilege] (deny)

pass:	This is an example subject line [SEC=OFFICIAL:Sensitive, CAVEAT=SH:NATIONAL-CABINET] (deny)

pass:	This is an example subject line [SEC=PROTECTED, EXPIRES=2019-07-01, DOWNTO=OFFICIAL] (deny)

pass:	This is an example subject line [SEC=SECRET, CAVEAT=SH:ACCOUNTABLE-MATERIAL, CAVEAT=RI:AUSTEO] (deny)

pass:	This is an example subject line [SEC=TOP-SECRET] (deny)

```

#### Header

regex: `X-Protective-Marking:(\n|.)*NS=gov\.au(\n|.)*SEC=(OFFICIAL:\s*Sensitive|PROTECTED|SECRET|TOP-SECRET)`

```
pass:	X-Protective-Marking: VER=2018.4, NS=gov.au,
SEC=UNOFFICIAL,
ORIGIN=neville.jones@entity.gov.au (allow)

pass:	X-Protective-Marking: VER=2018.4, NS=gov.au,
SEC=OFFICIAL,
ORIGIN=neville.jones@entity.gov.au (allow)

pass:	X-Protective-Marking: VER=2018.4, NS=gov.au,
SEC=OFFICIAL:Sensitive,
ORIGIN=neville.jones@entity.gov.au (deny)

pass:	X-Protective-Marking: VER=2018.4, NS=gov.au,
SEC=OFFICIAL: Sensitive,
ORIGIN=neville.jones@entity.gov.au (deny)

pass:	X-Protective-Marking: VER=2018.4, NS=gov.au,
SEC=OFFICIAL:Sensitive,
ACCESS=Legal-Privilege,
ORIGIN=neville.jones@entity.gov.au (deny)

pass:	X-Protective-Marking: VER=2018.4, NS=gov.au,
SEC=OFFICIAL:Sensitive,
CAVEAT=SH:NATIONAL-CABINET,
ORIGIN=neville.jones@entity.gov.au (deny)

pass:	X-Protective-Marking: VER=2018.4, NS=gov.au,
SEC=PROTECTED,
EXPIRES=2019-07-01,
DOWNTO=OFFICIAL,
ORIGIN=neville.jones@entity.gov.au (deny)

pass:	X-Protective-Marking: VER=2018.4, NS=gov.au,
SEC=SECRET,
CAVEAT=SH:ACCOUNTABLE-MATERIAL,
CAVEAT=RI:AUSTEO,
ORIGIN=neville.jones@entity.gov.au (deny)

pass:	X-Protective-Marking: VER=2018.4, NS=gov.au,
SEC=TOP-SECRET,
ORIGIN=neville.jones@entity.gov.au (deny)

```

#### Results

**Failures: 0**

