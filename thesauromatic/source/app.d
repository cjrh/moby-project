import std.stdio;
import std.string;
import std.getopt;
import std.algorithm.setops;
import std.algorithm.iteration;
import std.typecons;
import std.array;
import std.range;
import std.file: slurp;

string word;
/* private static string raw = import("mobythes.aur"); */
/* private static string wordsonly = import("wordsonly.txt"); */

/* string[][string] synonyms; */
/*  */
/* static this() { */
/*     synonyms = mixin(import("readymixin.txt")); */
/* } */

void main(string[] args)
{
    auto helpInformation = getopt(args);
    if (helpInformation.helpWanted)
    {
        defaultGetoptPrinter(
                "Usage: thesauromatic <word>\n\n" ~
                "Given <word> this program will print out a list\n" ~
                "of synonyms, one per line. This makes it easy to\n" ~
                "consume with other tools.\n",
                helpInformation.options);
    }

    if (args.length >= 2) {
        writeln(syns(args[1]));
    } else {
        writeln("ERROR: At least one word must be specified.");
        writeln(syns("blase"));
    }
}

private static string[string] process() {
    auto s = slurp!(string, string)("source/mobylf.txt", "%s,%s");
    /* auto lines = splitLines(raw); */
    string[string] result;
    /* auto f5 = File("readymixin.txt", "w"); */
    /* f5.writeln("["); */
    foreach (tup; s) {
        result[tup[0]] = tup[1];
        /* f5.writefln( */
        /*     "\"%s\": [%s],", */
        /*     items[0], map!(a => "\"" ~ a ~ "\"")(items[1..$]).join(",") */
        /* ); */
    }
    /* f5.writeln("]"); */
    return result;
}

private string syns(const string word) {
    auto x = process();
    if (word in x)
        return x[word].replace(",", "\n");
        /* return map(x[word].join("\n"); */
    return "";
}


/*
>>> with open('mobythes.aur') as f:
...     rows = f.readlines()

>>> len(rows)
30260

>>> from pprint import pprint

>>> from collections import Counter

>>> from itertools import chain

>>> c = Counter(chain.from_iterable(r.split(',') for r in rows))

>>> list(c.keys())[:10]
['a cappella', 'abbandono', 'accrescendo', 'affettuoso', 'agilmente', 'agitato', 'amabile', 'amoroso', 'appassionatamente', 'appassionato']

>>> c.most_common(10)
[('cut', 1120), ('set', 919), ('run', 749), ('turn', 703), ('check', 699), ('break', 697), ('line', 678), ('cast', 653), ('close', 645), ('pass', 633)]

>>> len(c.keys())
107980

*/
