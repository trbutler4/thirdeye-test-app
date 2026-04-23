// Type-only import against the local lost-pixel checkout (sibling repo).
// The CLI itself loads this file at runtime via tsx; the import is stripped.
import type { CustomProjectConfig } from "../lost-pixel/packages/cli/src/config";

export const config: CustomProjectConfig = {
  storybookShots: {
    storybookUrl: "./storybook-static",
  },

  // OSS mode
  generateOnly: true,
  failOnDifference: true,
};
