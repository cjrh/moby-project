import std.stdio;
import std.string;
import std.getopt;
import std.algorithm.setops;
import std.typecons;

string word;

void main(string[] args)
{
    /* auto helpInformation = getopt( */
    /*         args, */
    /*         "word", &word, */
    /*         ); */
    /*  */
    /* if (helpInformation.helpWanted) */
    /* { */
    /*     defaultGetoptPrinter("Usage: thesauromatic <word>", */
    /*             helpInformation.options); */
    /* } */

    if (args.length == 2) {
        writeln(syns(args[1]));
    } else if (args.length == 3) {
        writeln(
            setIntersection(syns(args[1]), syns(args[2]))
        );
    }
}

static string[][string] process() {
    const string raw = import("mobythes.aur");
    auto lines = splitLines(raw);
    /* writeln(lines[0..5]); */
    string[][string] result;
    foreach (line; lines) {
        auto items = line.split(",");
        result[items[0]] = items[1..$];
    }
    return result;
}

string[] syns(string word) {
    auto x = process();
    /* writeln(x[word]); */
    return x[word];
}
