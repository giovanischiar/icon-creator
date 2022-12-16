parent_path=$(cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P)

cd $parent_path
mkdir -p build
echo "$(                          \
  cat Android/*.swift             \
      $2/*.swift                \
      $2/*/*.swift              \
      $2/*/*/*.swift            \
      Library/VectorUI/*.swift    \
      SVG2PNGJSONConfig/*.swift   \
      Util/*.swift                \
      MainTraits.swift            \
      IconCreator.swift           \
      iOS/*.swift                 \
      iOS/*/*.swift               \
      Main.swift                  \
})" > build/IconCreator.swift

env -i swift build/IconCreator.swift $1
