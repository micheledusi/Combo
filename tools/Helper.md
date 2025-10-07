# Guide: Syncing Packages to Your Forked Typst Repository

This guide explains how to manage your package development workflow using a local clone of your package repository and a fork of the official Typst packages repository (`MicheleDusi/typst-packages`). It covers two scenarios:

## 1. First-Time Publication of a Package

**Goal:** Create a new branch in your forked repository for the package and publish its initial version.

### Steps

1. **Prepare your forked repository:**
	- Clone your fork of `typst/packages` (if not already done).
	- Set up sparse checkout for your package:
		```sh
		git clone --depth 1 --no-checkout --filter="tree:0" git@github.com:typst/packages
		cd typst-packages
		git sparse-checkout init
		git sparse-checkout set packages/preview/{package-name}
		```

2. **Create a development branch:**
	- Switch to `main` and pull latest changes:
		```sh
		git checkout main
		git pull upstream main
		```
	- Create and push a new branch for your package:
		```sh
		git checkout -b dev-{package-name}
		git push -u origin dev-{package-name}
		```

3. **Sync your package:**
	- In your package repo (e.g., `Combo`), run:
		```sh
		./tools/sync-to-packages.bat
		```
	- This copies your package to the correct versioned directory in your forked repo.

4. **Commit and push to your fork:**
	- Go to your forked repo:
		```sh
		cd ../typst-packages
		git add packages/preview/{package-name}
		git commit -m "{package-name}:0.1.0"
		git push origin dev-{package-name}
		```

5. **Create a pull request:**
   	- On GitHub, open a pull request from your branch to the official Typst packages repository.

---

## 2. Publishing a New Version of an Existing Package

**Goal:** Update your package and submit a new version to your forked repository.

### Steps

1. **Update your package code and version:**
	- Make changes in your package repo (e.g., `Combo`).
	- Update the version in `typst.toml`.

2. **Sync the new version:**
	- Run the sync script:
		```sh
		./tools/sync-to-packages.bat
		```

3. **Commit and push changes:**
	- Go to your forked repo:
		```sh
		cd ../typst-packages
		git add .
		git commit -m "{package-name}:X.Y.Z"
		git push origin dev-{package-name}
		```

4. **Create a pull request:**
   	- On GitHub, open a pull request for the new version.

---

## Notes

- Always ensure you are working on the correct branch in your forked repository.
- The sync script will copy your package to the correct versioned directory and warn about version mismatches.
- Use sparse checkout to avoid downloading unnecessary files from the forked repository.
