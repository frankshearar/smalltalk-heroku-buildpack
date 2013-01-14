| log source packages |

log := [:msg | | str |
    str := DateAndTime now printString, ': ', msg.
    FileStream stdout nextPutAll: str; nextPut: Character lf; flush.
    Transcript cr; show: str].

log value: '-----> Installing filetree'.
Installer ss3
    project: 'FileTree';
    install: 'ConfigurationOfFileTree'.
((Smalltalk at: #ConfigurationOfFileTree) project version: '1.0') load.

log value: '-----> Installing OSProcess'.
Installer ss
    project: 'OSProcess'
    install: 'OSProcess-dtl.73'.

"How do we find the actual repository? It's _by definition_ BUILD_DIR."
source := (Smalltalk at: #MCFileTreeRepository) path: ((Smalltalk at: UnixProcess) env at: 'BUILD_DIR').
packages := source allPackageNames.

"Load in the latest versions (for filetree there ought to be only one version
 per package."
packages do: [:pkg |
    (source highestNumberedVersionForPackageNamed: pkg) load].

"Load in any configurations found. There OUGHT to be only one...?"
((packages select: [:pkg |
    pkg startsWith: 'ConfigurationOf'])
        collect: #asSymbol)
            do: [:conf |
                log value: '-----> Installing ', conf.
                (Smalltalk at: conf) loadStable].
