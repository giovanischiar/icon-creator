parent_path=$(cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P)

cd $parent_path
mkdir -p build
echo "$(												  \
	cat Android/*.swift 	          \
			Icon/*.swift                \
			Icon/*/*.swift              \
			Icon/*/*/*.swift            \
			Library/VectorUI/*.swift    \
			SVG2PNGJSONConfig/*.swift 	\
			Util/*.swift                \
    	MainTraits.swift		        \
    	IconCreator.swift           \
    	Main.swift      		        \
})" > build/IconCreator.swift
swift build/IconCreator.swift $1