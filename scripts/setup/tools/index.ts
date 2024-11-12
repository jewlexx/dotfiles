export abstract class Tool {
  abstract pacman_install(): Promise<void>;

  setup(): void {}
}
