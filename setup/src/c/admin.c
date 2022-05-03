#ifdef _WIN32
#include <windows.h>
int IsElevated() {
  BOOL fRet = FALSE;
  HANDLE hToken = NULL;
  if (OpenProcessToken(GetCurrentProcess(), TOKEN_QUERY, &hToken)) {
    TOKEN_ELEVATION Elevation;
    DWORD cbSize = sizeof(TOKEN_ELEVATION);
    if (GetTokenInformation(hToken, TokenElevation, &Elevation,
                            sizeof(Elevation), &cbSize)) {
      fRet = Elevation.TokenIsElevated;
    }
  }
  if (hToken) {
    CloseHandle(hToken);
  }
  return fRet;
}
#else
#include <unistd.h>
int IsElevated() {
  uid_t uid = geteuid();

  if (uid == 0) {
    return 0;
  } else {
    return 1;
  }
}
#endif

int TestFunc() { return 32; }