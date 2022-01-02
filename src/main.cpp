#include <iostream>
#include <git2.h>
#include <sys/utsname.h>
#include <string>
#include <vector>
#include <termios.h>
#include <unistd.h>

using std::cout;
using std::endl;
using std::getline;
using std::string;
using std::vector;

// Copied from http://stackoverflow.com/
static void SetStdinEcho(bool enable = true)
{
    struct termios tty;
    tcgetattr(STDIN_FILENO, &tty);
    if (!enable)
        tty.c_lflag &= ~ECHO;
    else
        tty.c_lflag |= ECHO;

    (void)tcsetattr(STDIN_FILENO, TCSANOW, &tty);
}

static void get_os(vector<string> *details)
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

    string password;
    cout << "Please enter the root password: ";
    SetStdinEcho(false);
    getline(std::cin, password);
    SetStdinEcho();
    cout << "\rThank you :)" << endl;
}