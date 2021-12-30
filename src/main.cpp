#include <iostream>
#include <string>
#include <git2.h>
#include <sys/types.h>
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

    std::cout << dotfiles_char << "\n";

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

    int success = clone_dotfiles();

    if (success != 0)
    {
        std::cout << "Clone failed. Double check if the directory already exists?\n";
        for (int i = 5; i > 0; i--)
        {
            std::cout << "\rContinuing in " << i << std::flush;
            sleep(1);
        }
        std::cout << "\n";
    }
}
