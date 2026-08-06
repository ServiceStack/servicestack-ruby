// Files that declare the version, kept in sync with package.json by `npm run bump`.
export const versionFiles = [
    {
        file: 'lib/servicestack/version.rb',
        find: (v) => `VERSION = '${v}'`,
        replace: (v) => `VERSION = '${v}'`,
    },
]

export const replacements = []
