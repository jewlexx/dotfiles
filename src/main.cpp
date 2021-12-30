#include <iostream>
#include <string>
#include <git2.h>
#include <sys/types.h>
#include <sys/utsname.h>
#include <thread>
#include <pwd.h>
#include <unistd.h>

using std::string;

int clone_dotfiles()
{
    passwd *pw = getpwuid(getuid());
    char *home_dir = pw->pw_dir;

    std::string dotfiles(home_dir);
    dotfiles.append("/dotfilestemp");

    const char *dotfiles_char = dotfiles.c_str();

    git_repository *repo = NULL;

    int success = git_clone(&repo, "https://github.com/jamesinaxx/dotfiles.git", dotfiles_char, NULL);

    git_repository_free(repo);

    return success;
}

const void print_title()
{
    std::cout << "   _                           _                        _     \n";
    std::cout << "  (_) __ _ _ __ ___   ___  ___(_)_ __   __ ___  ____  _( )___ \n";
    std::cout << "  | |/ _` | '_ ` _ \\ / _ \\/ __| | '_ \\ / _` \\ \\/ /\\ \\/ /// __|\n";
    std::cout << "  | | (_| | | | | | |  __/\\__ \\ | | | | (_| |>  <  >  <  \\__ \\\n";
    std::cout << " _/ |\\__,_|_| |_| |_|\\___||___/_|_| |_|\\__,_/_/\\_\\/_/\\_\\ |___/\n";
    std::cout << "|__/                                                          \n";
    std::cout << "     _       _    __ _ _           \n";
    std::cout << "  __| | ___ | |_ / _(_) | ___  ___ \n";
    std::cout << " / _` |/ _ \\| __| |_| | |/ _ \\/ __|\n";
    std::cout << "| (_| | (_) | |_|  _| | |  __/\\__ \\\n";
    std::cout << " \\__,_|\\___/ \\__|_| |_|_|\\___||___/\n";
    std::cout << "\n";
}

int main()
{
    print_title();
    git_libgit2_init();

    std::thread clone_thread(clone_dotfiles);

    string distro;

    if (!system("which pacman > /dev/null 2>&1"))
    {
        distro = "arch";
    }
    else if (!system("which pacman > /dev/null 2>&1"))
    {
        distro = "debian";
    }
    else
    {
        std::cout << "Apologies, Your distro is not supported";
        return 0;
    }

    // Joins the clone thread
    if (clone_thread.joinable())
    {
        std::cout << "Finishing up repo clone" << std::flush;
        clone_thread.join();
        std::cout << string(27, '\b');
    }

    std::cout << "Running " << distro << " setup script\n";
}
