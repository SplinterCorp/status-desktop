import NimQml
import chronicles
import ../../../status/profile/profile
import ../../../status/libstatus/types
import std/wrapnils

QtObject:
  type ProfileInfoView* = ref object of QObject
    username*: string
    identicon*: string
    address*: string
    identityImage*: IdentityImage
    pubKey*: string
    appearance*: int
    ensVerified*: bool
    acceptChatsContactsOnly*: bool

  proc setup(self: ProfileInfoView) =
    self.QObject.setup

  proc delete*(self: ProfileInfoView) =
    self.QObject.delete

  proc newProfileInfoView*(): ProfileInfoView =
    new(result, delete)
    result = ProfileInfoView()
    result.pubKey = ""
    result.username = ""
    result.identicon = ""
    result.appearance = 0
    result.identityImage = IdentityImage()
    result.ensVerified = false
    result.acceptChatsContactsOnly = false
    result.setup

  proc profileChanged*(self: ProfileInfoView) {.signal.}

  proc identityImageChanged*(self: ProfileInfoView) {.signal.}

  proc setProfile*(self: ProfileInfoView, profile: Profile) =
    self.username = profile.username
    self.identicon = profile.identicon
    self.appearance = profile.appearance
    self.pubKey = profile.id
    self.address = profile.address
    self.ensVerified = profile.ensVerified
    self.identityImage = profile.identityImage
    self.acceptChatsContactsOnly = profile.acceptChatsContactsOnly
    self.profileChanged()

  proc setIdentityImage*(self: ProfileInfoView, identityImage: IdentityImage) =
    self.identityImage = identityImage
    self.identityImageChanged()

  proc removeIdentityImage*(self: ProfileInfoView) =
    self.identityImage = IdentityImage()
    self.identityImageChanged()

  proc username*(self: ProfileInfoView): string {.slot.} = result = self.username
  QtProperty[string] username:
    read = username
    notify = profileChanged

  proc appearance*(self: ProfileInfoView): int {.slot.} = result = self.appearance
  proc setAppearance*(self: ProfileInfoView, appearance: int) {.slot.} =
    if self.appearance == appearance:
      return
    self.appearance = appearance
    self.profileChanged()
  QtProperty[int] appearance:
    read = appearance
    write = setAppearance
    notify = profileChanged

  proc acceptChatsContactsOnly*(self: ProfileInfoView): bool {.slot.} = result = self.acceptChatsContactsOnly
  proc setAcceptChatsContactsOnly*(self: ProfileInfoView, acceptChatsContactsOnly: bool) {.slot.} =
    if self.acceptChatsContactsOnly == acceptChatsContactsOnly:
      return
    self.acceptChatsContactsOnly = acceptChatsContactsOnly
    self.profileChanged()
  QtProperty[bool] acceptChatsContactsOnly:
    read = acceptChatsContactsOnly
    write = setAcceptChatsContactsOnly
    notify = profileChanged

  proc identicon*(self: ProfileInfoView): string {.slot.} = result = self.identicon
  QtProperty[string] identicon:
    read = identicon
    notify = profileChanged

  proc thumbnailImage*(self: ProfileInfoView): string {.slot.} =
    if (?.self.identityImage.thumbnail != ""):
      result = self.identityImage.thumbnail
    else:
      result = self.identicon
  QtProperty[string] thumbnailImage:
    read = thumbnailImage
    notify = identityImageChanged

  proc largeImage*(self: ProfileInfoView): string {.slot.} =
    if (?.self.identityImage.large != ""):
      result = self.identityImage.large
    else:
      result = self.identicon
  QtProperty[string] largeImage:
    read = largeImage
    notify = identityImageChanged

  proc hasIdentityImage*(self: ProfileInfoView): bool {.slot.} =
    result = (?.self.identityImage.thumbnail != "")
  QtProperty[bool] hasIdentityImage:
    read = hasIdentityImage
    notify = identityImageChanged

  proc pubKey*(self: ProfileInfoView): string {.slot.} = self.pubKey

  QtProperty[string] pubKey:
    read = pubKey
    notify = profileChanged

  proc address*(self: ProfileInfoView): string {.slot.} = self.address

  QtProperty[string] address:
    read = address
    notify = profileChanged

  proc ensVerified*(self: ProfileInfoView): bool {.slot.} = self.ensVerified

  QtProperty[bool] ensVerified:
    read = ensVerified
    notify = profileChanged
