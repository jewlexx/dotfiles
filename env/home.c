#include <stdio.h>
#include <stdlib.h>

int main() {
#ifdef _WIN32
  char *home_dir = getenv("USERPROFILE");
#else
  char *home_dir = getenv("HOME");
#endif

  printf("%s", home_dir);
}