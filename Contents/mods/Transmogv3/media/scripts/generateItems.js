const header =
  `module TransmogV3 {
	imports	{
		Base
	}
`

const footer = `}`

const templateClone = (idx) =>
  `  item TransmogClone_${idx} {
    DisplayCategory = Transmog,
    Type = Clothing,
    DisplayName = TransmogClone_${idx},
    ClothingItem = InvisibleItem,
    BodyLocation = Transmog_Hidden,
    Icon = NoseRing_Gold,
    Weight = 0,
  }
`
const templateCosmetic = (idx) =>
  `  item TransmogCosmetic_${idx} {
    DisplayCategory = Transmog,
    Type = Clothing,
    Cosmetic = TRUE,
    DisplayName = TransmogCosmetic_${idx},
    ClothingItem = InvisibleItem,
    BodyLocation = Transmog_Cosmetic,
    Icon = NoseRing_Gold,
    Weight = 0,
  }
`

// i + 1, lua counts from 1
const templatesClone = Array.from({ length: 500 }, (_, i) => templateClone(i + 1));
const textClone = header + templatesClone.join('') + footer

const fs = require('fs')
fs.writeFile('./TransmogClones.txt', textClone, err => {
  if (err) {
    console.error(err)
    return
  }
})

const templatesCosmetic = Array.from({ length: 500 }, (_, i) => templateCosmetic(i + 1));
const textCosmetic = header + templatesCosmetic.join('') + footer
fs.writeFile('./TransmogCosmetic.txt', textCosmetic, err => {
  if (err) {
    console.error(err)
    return
  }
})

console.log("Done")