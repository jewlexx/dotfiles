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

int main()
{
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
