#include <iostream>
#include <git2.h>
#include <sys/utsname.h>
#include <string>
#include <vector>
#include <termios.h>
#include <unistd.h>

#include "include/spinners.hpp"

using std::cout;
using std::endl;
using std::getline;
using std::string;
using std::vector;

using namespace spinners;

class Git
{
public:
    int success{};

    Git()
    {
        success = git_libgit2_init();
    }

    ~Git()
    {
        git_libgit2_shutdown();
    }
};

// Copied from http://stackoverflow.com/
void SetStdinEcho(bool enable = true)
{
    struct termios tty;
    tcgetattr(STDIN_FILENO, &tty);
    if (!enable)
        tty.c_lflag &= ~ECHO;
    else
        tty.c_lflag |= ECHO;

    (void)tcsetattr(STDIN_FILENO, TCSANOW, &tty);
}

void get_os(vector<string> *details)
{
    utsname name;
    uname(&name);

    details->push_back(name.release);
    details->push_back(name.sysname);
}

string get_passwd()
{
    string password;
    cout << "Please enter the root password: ";
    SetStdinEcho(false);
    getline(std::cin, password);
    SetStdinEcho();
    cout << "\rThank you :)" << endl;

    return password;
}

git_repository *clone_dotfiles()
{
    Spinner spinner;

    spinner.setText("Cloning dotfiles repository...");
    spinner.setSymbols("dots4");

    spinner.start();

    git_repository *repo;

    git_clone(&repo, "https://github.com/jamesinaxx/dotfiles.git", "/home/james/dotfilestemp", NULL);

    spinner.stop();

    return repo;
}

string get_pacman()
{
    if (!system("which pacman > /dev/null 2>&1"))
    {
        return "pacman";
    }
    else if (!system("which apt > /dev/null 2>&1"))
    {
        return "apt";
    }
    else
    {
        return "unknown";
    }
}

int main()
{
    vector<string> *details = new vector<string>();
    get_os(details);

    const string version = details->at(0);
    const string os = details->at(1);
    const string pacman = get_pacman();

    if (pacman == "unknown")
    {
        cout << "Sorry, this only supports Arch, and Debian based distributions." << endl;
        return 1;
    }

    delete details;

    if (os != "Linux")
    {
        cout << "Sorry, this only supports Linux." << endl;
        return 1;
    }

    cout << "Running on Linux, kernel version " << version << endl;

    string passwd = get_passwd();

    Git *git = new Git();

    clone_dotfiles();

    delete git;
}