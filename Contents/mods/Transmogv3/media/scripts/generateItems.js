const header =
`module TransmogV3 {
	imports	{
		Base
	}
`

const footer = `}`

const templateHide = (idx) => 
`  item TransmogHide_${idx} {
    DisplayCategory = Transmog,
    Type = Clothing,
    DisplayName = TransmogHide_${idx},
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
const templatesHide = Array.from({ length: 500 }, (_, i) => templateHide(i + 1));
const textHide = header+templatesHide.join('')+footer

const fs = require('fs')
fs.writeFile('./TransmogHide.txt', textHide, err => {
  if (err) {
    console.error(err)
    return
  }
})

const templatesCosmetic = Array.from({ length: 500 }, (_, i) => templateCosmetic(i + 1));
const textCosmetic = header+templatesCosmetic.join('')+footer
fs.writeFile('./TransmogCosmetic.txt', textCosmetic, err => {
  if (err) {
    console.error(err)
    return
  }
})

console.log("Done")