const core = require("@actions/core");
const tc = require("@actions/tool-cache");
const path = require("path");
const semver = require("semver");

/**
 * Setup for Python from the GitHub Actions tool cache
 * Converted from https://github.com/actions/setup-python
 *
 * @param {string} versionSpec version of Python
 * @param {string} arch architecture (x64|x32)
 */
let setupPython = function(versionSpec, arch) {
  return new Promise((resolve, reject) => {
    const IS_WINDOWS = process.platform === "win32";

    // Find the version of Python we want in the tool cache
    const installDir = tc.find("Python", versionSpec, arch);
    core.debug(`installDir: ${installDir}`);

    // Set paths
    core.exportVariable("pythonLocation", installDir);
    core.addPath(installDir);
    if (IS_WINDOWS) {
      core.addPath(path.join(installDir, "Scripts"));
    } else {
      core.addPath(path.join(installDir, "bin"));
    }

    if (IS_WINDOWS) {
      // Add --user directory
      // `installDir` from tool cache should look like $AGENT_TOOLSDIRECTORY/Python/<semantic version>/x64/
      // So if `findLocalTool` succeeded above, we must have a conformant `installDir`
      const version = path.basename(path.dirname(installDir));
      const major = semver.major(version);
      const minor = semver.minor(version);

      const userScriptsDir = path.join(
        process.env["APPDATA"] || "",
        "Python",
        `Python${major}${minor}`,
        "Scripts"
      );
      core.addPath(userScriptsDir);
    }
    // On Linux and macOS, pip will create the --user directory and add it to PATH as needed.

    resolve();
  });
};

module.exports = setupPython;
