#include <iostream>
#include <git2.h>
#include <sys/utsname.h>
#include <string>
#include <vector>

using std::cout;
using std::endl;
using std::string;
using std::vector;

void get_os(vector<string> *details)
{
    utsname name;
    uname(&name);

    details->push_back(name.release);
    details->push_back(name.sysname);
}

int main()
{
    vector<string> details;
    get_os(&details);

    const string version = details[0];
    const string os = details[1];

    cout << "Running on " << os << " v" << version << endl;
}