"use strict";

// src/utils/getWeaponNameFromHash.ts
var WEAPON_HASHES = {
  "100416529": "Sniper Rifle",
  "101631238": "Fire Extinguisher",
  "125959754": "Compact Grenade Launcher",
  "126349499": "Snowball",
  "137902532": "Vintage Pistol",
  "171789620": "Combat PDW",
  "177293209": "Heavy Sniper Mk II",
  "205991906": "Heavy Sniper",
  "317205821": "Sweeper Shotgun",
  "324215364": "Micro SMG",
  "419712736": "Pipe Wrench",
  "453432689": "Pistol",
  "487013001": "Pump Shotgun",
  "584646201": "AP Pistol",
  "600439132": "Ball",
  "615608432": "Molotov",
  "736523883": "SMG",
  "741814745": "Sticky Bomb",
  "883325847": "Jerry Can",
  "911657153": "Stun Gun",
  "940833800": "Stone Hatchet",
  "961495388": "Assault Rifle Mk II",
  "984333226": "Heavy Shotgun",
  "1119849093": "Minigun",
  "1141786504": "Golf Club",
  "1198256469": "Unholy Hellbringer",
  "1198879012": "Flare Gun",
  "1233104067": "Flare",
  "1317494643": "Hammer",
  "1432025498": "Pump Shotgun Mk II",
  "1593441988": "Combat Pistol",
  "1627465347": "Gusenberg Sweeper",
  "1649403952": "Compact Rifle",
  "1672152130": "Homing Launcher",
  "1737195953": "Nightstick",
  "1785463520": "Marksman Rifle Mk II",
  "1834241177": "Railgun",
  "2017895192": "Sawed-Off Shotgun",
  "2024373456": "SMG Mk II",
  "2132975508": "Bullpup Rifle",
  "2138347493": "Firework Launcher",
  "2144741730": "Combat MG",
  "2210333304": "Carbine Rifle",
  "2227010557": "Crowbar",
  "2228681469": "Bullpup Rifle Mk II",
  "2285322324": "SNS Pistol Mk II",
  "2343591895": "Flashlight",
  "2460120199": "Antique Cavalry Dagger",
  "2481070269": "Grenade",
  "2484171525": "Pool Cue",
  "2508868239": "Baseball Bat",
  "2526821735": "Special Carbine Mk II",
  "2548703416": "Double-Action Revolver",
  "2578377531": "Pistol .50",
  "2578778090": "Knife",
  "2634544996": "MG",
  "2640438543": "Bullpup Shotgun",
  "2694266206": "BZ Gas",
  "2726580491": "Grenade Launcher",
  "2828843422": "Musket",
  "2874559379": "Proximity Mine",
  "2937143193": "Advanced Rifle",
  "2939590305": "Up-n-Atomizer",
  "2982836145": "RPG",
  "3056410471": "Widowmaker",
  "3125143736": "Pipe Bomb",
  "3173288789": "Mini SMG",
  "3218215474": "SNS Pistol",
  "3219281620": "Pistol Mk II",
  "3220176749": "Assault Rifle",
  "3231910285": "Special Carbine",
  "3249783761": "Heavy Revolver",
  "3342088282": "Marksman Rifle",
  "3415619887": "Heavy Revolver Mk II",
  "3441901897": "Battle Axe",
  "3523564046": "Heavy Pistol",
  "3638508604": "Knuckle Duster",
  "3675956304": "Machine Pistol",
  "3686625920": "Combat MG Mk II",
  "3696079510": "Marksman Pistol",
  "3713923289": "Machete",
  "3756226112": "Switchblade",
  "3800352039": "Assault Shotgun",
  "4019527611": "Double Barrel Shotgun",
  "4024951519": "Assault SMG",
  "4191993645": "Hatchet",
  "4192643659": "Bottle",
  "4208062921": "Carbine Rifle Mk II",
  "4256991824": "Tear Gas"
};
function getWeaponNameFromHash(hash) {
  const name = WEAPON_HASHES[hash.toString(10)];
  if (name) {
    return name;
  }
  return null;
}

// src/utils/getWeapon.ts
function getWeapon(pedId) {
  const weaponHash = GetSelectedPedWeapon(pedId);
  const hash = getWeaponNameFromHash(weaponHash);
  return hash;
}

// src/utils/getArea.ts
var areaHashes = {
  "2072609373": "Blaine County",
  "-289320599": "Los Santos"
};
function getArea(position) {
  const areaHash = GetHashOfMapAreaAtCoords(...position);
  return areaHashes[areaHash];
}

// src/utils/getZone.ts
var areaHashes2 = {
  [GetHashKey("AIRP")]: "Los Santos International Airport",
  [GetHashKey("ALAMO")]: "Alamo Sea",
  [GetHashKey("ALTA")]: "Alta",
  [GetHashKey("ARMYB")]: "Fort Zancudo",
  [GetHashKey("BANHAMC")]: "Banham Canyon Dr",
  [GetHashKey("BANNING")]: "Banning",
  [GetHashKey("BEACH")]: "Vespucci Beach",
  [GetHashKey("BHAMCA")]: "Banham Canyon",
  [GetHashKey("BRADP")]: "Braddock Pass",
  [GetHashKey("BRADT")]: "Braddock Tunnel",
  [GetHashKey("BURTON")]: "Burton",
  [GetHashKey("CALAFB")]: "Calafia Bridge",
  [GetHashKey("CANNY")]: "Raton Canyon",
  [GetHashKey("CCREAK")]: "Cassidy Creek",
  [GetHashKey("CHAMH")]: "Chamberlain Hills",
  [GetHashKey("CHIL")]: "Vinewood Hills",
  [GetHashKey("CHU")]: "Chumash",
  [GetHashKey("CMSW")]: "Chiliad Mountain State Wilderness",
  [GetHashKey("CYPRE")]: "Cypress Flats",
  [GetHashKey("DAVIS")]: "Davis",
  [GetHashKey("DELBE")]: "Del Perro Beach",
  [GetHashKey("DELPE")]: "Del Perro",
  [GetHashKey("DELSOL")]: "La Puerta",
  [GetHashKey("DESRT")]: "Grand Senora Desert",
  [GetHashKey("DOWNT")]: "Downtown",
  [GetHashKey("DTVINE")]: "Downtown Vinewood",
  [GetHashKey("EAST_V")]: "East Vinewood",
  [GetHashKey("EBURO")]: "El Burro Heights",
  [GetHashKey("ELGORL")]: "El Gordo Lighthouse",
  [GetHashKey("ELYSIAN")]: "Elysian Island",
  [GetHashKey("GALFISH")]: "Galilee",
  [GetHashKey("GOLF")]: "GWC and Golfing Society",
  [GetHashKey("GRAPES")]: "Grapeseed",
  [GetHashKey("GREATC")]: "Great Chaparral",
  [GetHashKey("HARMO")]: "Harmony",
  [GetHashKey("HAWICK")]: "Hawick",
  [GetHashKey("HORS")]: "Vinewood Racetrack",
  [GetHashKey("HUMLAB")]: "Humane Labs and Research",
  [GetHashKey("JAIL")]: "Bolingbroke Penitentiary",
  [GetHashKey("KOREAT")]: "Little Seoul",
  [GetHashKey("LACT")]: "Land Act Reservoir",
  [GetHashKey("LAGO")]: "Lago Zancudo",
  [GetHashKey("LDAM")]: "Land Act Dam",
  [GetHashKey("LEGSQU")]: "Legion Square",
  [GetHashKey("LMESA")]: "La Mesa",
  [GetHashKey("LOSPUER")]: "La Puerta",
  [GetHashKey("MIRR")]: "Mirror Park",
  [GetHashKey("MORN")]: "Morningwood",
  [GetHashKey("MOVIE")]: "Richards Majestic",
  [GetHashKey("MTCHIL")]: "Mount Chiliad",
  [GetHashKey("MTGORDO")]: "Mount Gordo",
  [GetHashKey("MTJOSE")]: "Mount Josiah",
  [GetHashKey("MURRI")]: "Murrieta Heights",
  [GetHashKey("NCHU")]: "North Chumash",
  [GetHashKey("NOOSE")]: "N.O.O.S.E",
  [GetHashKey("OCEANA")]: "Pacific Ocean",
  [GetHashKey("PALCOV")]: "Paleto Cove",
  [GetHashKey("PALETO")]: "Paleto Bay",
  [GetHashKey("PALFOR")]: "Paleto Forest",
  [GetHashKey("PALHIGH")]: "Palomino Highlands",
  [GetHashKey("PALMPOW")]: "Palmer-Taylor Power Station",
  [GetHashKey("PBLUFF")]: "Pacific Bluffs",
  [GetHashKey("PBOX")]: "Pillbox Hill",
  [GetHashKey("PROCOB")]: "Procopio Beach",
  [GetHashKey("RANCHO")]: "Rancho",
  [GetHashKey("RGLEN")]: "Richman Glen",
  [GetHashKey("RICHM")]: "Richman",
  [GetHashKey("ROCKF")]: "Rockford Hills",
  [GetHashKey("RTRAK")]: "Redwood Lights Track",
  [GetHashKey("SANAND")]: "San Andreas",
  [GetHashKey("SANCHIA")]: "San Chianski Mountain Range",
  [GetHashKey("SANDY")]: "Sandy Shores",
  [GetHashKey("SKID")]: "Mission Row",
  [GetHashKey("SLAB")]: "Stab City",
  [GetHashKey("STAD")]: "Maze Bank Arena",
  [GetHashKey("STRAW")]: "Strawberry",
  [GetHashKey("TATAMO")]: "Tataviam Mountains",
  [GetHashKey("TERMINA")]: "Terminal",
  [GetHashKey("TEXTI")]: "Textile City",
  [GetHashKey("TONGVAH")]: "Tongva Hills",
  [GetHashKey("TONGVAV")]: "Tongva Valley",
  [GetHashKey("VCANA")]: "Vespucci Canals",
  [GetHashKey("VESP")]: "Vespucci",
  [GetHashKey("VINE")]: "Vinewood",
  [GetHashKey("WINDF")]: "Ron Alternates Wind Farm",
  [GetHashKey("WVINE")]: "West Vinewood",
  [GetHashKey("ZANCUDO")]: "Zancudo River",
  [GetHashKey("ZP_ORT")]: "Port of South Los Santos",
  [GetHashKey("ZQ_UAR")]: "Davis Quartz"
};
function getZone(position) {
  const areaHash = GetHashKey(GetNameOfZone(...position));
  return areaHashes2[areaHash];
}

// src/utils/getLocation.ts
function getLocation(pos) {
  const [lastStreet] = GetStreetNameAtCoord(...pos);
  const streetName = GetStreetNameFromHashKey(lastStreet);
  const zone = getZone(pos);
  const area = getArea(pos);
  const location = `${streetName}, ${zone} (${area})`;
  return location;
}

// src/utils/getVehicle.ts
function getVehicle(pedId) {
  const vehicle = GetVehiclePedIsIn(pedId, false);
  if (vehicle === 0) {
    return {};
  }
  const licensePlate = GetVehicleNumberPlateText(vehicle);
  const hasSirenEnabled = isSirenEnabled(vehicle);
  let vehicleName = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)));
  if (vehicleName === "NULL") {
    vehicleName = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle));
  }
  return { licensePlate, vehicle: vehicleName, hasSirenEnabled };
}
function isSirenEnabled(vehicle) {
  const sirenEnabledValue = IsVehicleSirenOn(vehicle) || IsVehicleSirenAudioOn(vehicle) || IsVehicleSirenSoundOn(vehicle);
  if (typeof sirenEnabledValue === "number") {
    return sirenEnabledValue === 1;
  }
  return sirenEnabledValue;
}

// src/utils/getIcon.ts
function getIcon(pedId) {
  if (!IsPedInAnyVehicle(pedId, false))
    return 6;
  const vehicle = GetVehiclePedIsIn(pedId, false);
  if (vehicle === 0) {
    return 6;
  }
  const vehicleModel = GetEntityModel(vehicle);
  if (isPoliceVehicle(vehicle))
    return 56;
  if (isTowTruck(vehicleModel))
    return 68;
  if (IsThisModelAHeli(vehicleModel))
    return 64;
  return 225;
}
function isPoliceVehicle(vehicle) {
  const vehicleClass = GetVehicleClass(vehicle);
  return vehicleClass === 18;
}
function isTowTruck(vehicleModel) {
  const hashes = [GetHashKey("towtruck"), GetHashKey("towtruck2")];
  return hashes.includes(vehicleModel);
}

// integration/client/client.ts
var firstSpawn = true;
onNet("playerDropped" /* CFXPlayerDropped */, () => {
  if (firstSpawn) {
    emitPlayerData();
    firstSpawn = false;
  }
});
setInterval(() => {
  emitPlayerData();
}, 500);
function emitPlayerData() {
  const [playerX, playerY, playerZ] = GetEntityCoords(PlayerPedId(), false);
  const vehicle = getVehicle(PlayerPedId());
  const weapon = getWeapon(PlayerPedId());
  const location = getLocation([playerX, playerY, playerZ]);
  const icon = getIcon(PlayerPedId());
  emitNet("sna-live-map-player-spawned" /* PlayerSpawned */, {
    playerId: PlayerPedId(),
    name: GetPlayerName(PlayerId()),
    location,
    pos: { x: playerX, y: playerY, z: playerZ },
    weapon,
    icon,
    ...vehicle
  });
}
