local pokedex = {}
pokedex[000] = {name="MissingNo.", type1=nil,        type2=nil,        rby_icon=nil}
pokedex[001] = {name="Bulbasaur",  type1="grass",    type2="poison",   rby_icon="plant"}
pokedex[002] = {name="Ivysaur",    type1="grass",    type2="poison",   rby_icon="plant"}
pokedex[003] = {name="Venusaur",   type1="grass",    type2="poison",   rby_icon="plant"}
pokedex[004] = {name="Charmander", type1="fire",     type2=nil,        rby_icon="biped"}
pokedex[005] = {name="Charmeleon", type1="fire",     type2=nil,        rby_icon="biped"}
pokedex[006] = {name="Charizard",  type1="fire",     type2="flying",   rby_icon="biped"}
pokedex[007] = {name="Squirtle",   type1="water",    type2=nil,        rby_icon="water"}
pokedex[008] = {name="Wartortle",  type1="water",    type2=nil,        rby_icon="water"}
pokedex[009] = {name="Blastoise",  type1="water",    type2=nil,        rby_icon="water"}
pokedex[010] = {name="Caterpie",   type1="bug",      type2=nil,        rby_icon="insect"}
pokedex[011] = {name="Metapod",    type1="bug",      type2=nil,        rby_icon="insect"}
pokedex[012] = {name="Butterfree", type1="bug",      type2="flying",   rby_icon="insect"}
pokedex[013] = {name="Weedle",     type1="bug",      type2="poison",   rby_icon="insect"}
pokedex[014] = {name="Kakuna",     type1="bug",      type2="poison",   rby_icon="insect"}
pokedex[015] = {name="Beedrill",   type1="bug",      type2="poison",   rby_icon="insect"}
pokedex[016] = {name="Pidgey",     type1="normal",   type2="flying",   rby_icon="bird"}
pokedex[017] = {name="Pidgeotto",  type1="normal",   type2="flying",   rby_icon="bird"}
pokedex[018] = {name="Pidgeot",    type1="normal",   type2="flying",   rby_icon="bird"}
pokedex[019] = {name="Rattata",    type1="normal",   type2=nil,        rby_icon="quadruped"}
pokedex[020] = {name="Raticate",   type1="normal",   type2=nil,        rby_icon="quadruped"}
pokedex[021] = {name="Spearow",    type1="normal",   type2="flying",   rby_icon="bird"}
pokedex[022] = {name="Fearow",     type1="normal",   type2="flying",   rby_icon="bird"}
pokedex[023] = {name="Ekans",      type1="poison",   type2=nil,        rby_icon="snake"}
pokedex[024] = {name="Arbok",      type1="poison",   type2=nil,        rby_icon="snake"}
pokedex[025] = {name="Pikachu",    type1="electric", type2=nil,        rby_icon="pikachu"}
pokedex[026] = {name="Raichu",     type1="electric", type2=nil,        rby_icon="fairy"}
pokedex[027] = {name="Sandshrew",  type1="ground",   type2=nil,        rby_icon="biped"}
pokedex[028] = {name="Sandslash",  type1="ground",   type2=nil,        rby_icon="biped"}
pokedex[029] = {name="Nidoran#",   type1="poison",   type2=nil,        rby_icon="biped"}
pokedex[030] = {name="Nidorina",   type1="poison",   type2=nil,        rby_icon="biped"}
pokedex[031] = {name="Nidoqueen",  type1="poison",   type2="ground",   rby_icon="biped"}
pokedex[032] = {name="Nidoran@",   type1="poison",   type2=nil,        rby_icon="biped"}
pokedex[033] = {name="Nidorino",   type1="poison",   type2=nil,        rby_icon="biped"}
pokedex[034] = {name="Nidoking",   type1="poison",   type2="ground",   rby_icon="biped"}
pokedex[035] = {name="Clefairy",   type1="normal",   type2=nil,        rby_icon="fairy"}
pokedex[036] = {name="Clefable",   type1="normal",   type2=nil,        rby_icon="fairy"}
pokedex[037] = {name="Vulpix",     type1="fire",     type2=nil,        rby_icon="quadruped"}
pokedex[038] = {name="Ninetales",  type1="fire",     type2=nil,        rby_icon="quadruped"}
pokedex[039] = {name="Jigglypuff", type1="normal",   type2=nil,        rby_icon="fairy"}
pokedex[040] = {name="Wigglytuff", type1="normal",   type2=nil,        rby_icon="fairy"}
pokedex[041] = {name="Zubat",      type1="poison",   type2="flying",   rby_icon="biped"}
pokedex[042] = {name="Golbat",     type1="poison",   type2="flying",   rby_icon="biped"}
pokedex[043] = {name="Oddish",     type1="grass",    type2="poison",   rby_icon="plant"}
pokedex[044] = {name="Gloom",      type1="grass",    type2="poison",   rby_icon="plant"}
pokedex[045] = {name="Vileplume",  type1="grass",    type2="poison",   rby_icon="plant"}
pokedex[046] = {name="Paras",      type1="bug",      type2="grass",    rby_icon="insect"}
pokedex[047] = {name="Parasect",   type1="bug",      type2="grass",    rby_icon="insect"}
pokedex[048] = {name="Venonat",    type1="bug",      type2="poison",   rby_icon="insect"}
pokedex[049] = {name="Venomoth",   type1="bug",      type2="poison",   rby_icon="insect"}
pokedex[050] = {name="Diglett",    type1="ground",   type2=nil,        rby_icon="biped"}
pokedex[051] = {name="Dugtrio",    type1="ground",   type2=nil,        rby_icon="biped"}
pokedex[052] = {name="Meowth",     type1="normal",   type2=nil,        rby_icon="biped"}
pokedex[053] = {name="Persian",    type1="normal",   type2=nil,        rby_icon="biped"}
pokedex[054] = {name="Psyduck",    type1="water",    type2=nil,        rby_icon="biped"}
pokedex[055] = {name="Golduck",    type1="water",    type2=nil,        rby_icon="biped"}
pokedex[056] = {name="Mankey",     type1="fighting", type2=nil,        rby_icon="biped"}
pokedex[057] = {name="Primeape",   type1="fighting", type2=nil,        rby_icon="biped"}
pokedex[058] = {name="Growlithe",  type1="fire",     type2=nil,        rby_icon="quadruped"}
pokedex[059] = {name="Arcanine",   type1="fire",     type2=nil,        rby_icon="quadruped"}
pokedex[060] = {name="Poliwag",    type1="water",    type2=nil,        rby_icon="biped"}
pokedex[061] = {name="Poliwhirl",  type1="water",    type2=nil,        rby_icon="biped"}
pokedex[062] = {name="Poliwrath",  type1="water",    type2="fighting", rby_icon="biped"}
pokedex[063] = {name="Abra",       type1="psychic",  type2=nil,        rby_icon="biped"}
pokedex[064] = {name="Kadabra",    type1="psychic",  type2=nil,        rby_icon="biped"}
pokedex[065] = {name="Alakazam",   type1="psychic",  type2=nil,        rby_icon="biped"}
pokedex[066] = {name="Machop",     type1="fighting", type2=nil,        rby_icon="biped"}
pokedex[067] = {name="Machoke",    type1="fighting", type2=nil,        rby_icon="biped"}
pokedex[068] = {name="Machamp",    type1="fighting", type2=nil,        rby_icon="biped"}
pokedex[069] = {name="Bellsprout", type1="grass",    type2="poison",   rby_icon="plant"}
pokedex[070] = {name="Weepinbell", type1="grass",    type2="poison",   rby_icon="plant"}
pokedex[071] = {name="Victreebel", type1="grass",    type2="poison",   rby_icon="plant"}
pokedex[072] = {name="Tentacool",  type1="water",    type2="poison",   rby_icon="water"}
pokedex[073] = {name="Tentacruel", type1="water",    type2="poison",   rby_icon="water"}
pokedex[074] = {name="Geodude",    type1="rock",     type2="ground",   rby_icon="biped"}
pokedex[075] = {name="Graveler",   type1="rock",     type2="ground",   rby_icon="biped"}
pokedex[076] = {name="Golem",      type1="rock",     type2="ground",   rby_icon="biped"}
pokedex[077] = {name="Ponyta",     type1="fire",     type2=nil,        rby_icon="quadruped"}
pokedex[078] = {name="Rapidash",   type1="fire",     type2=nil,        rby_icon="quadruped"}
pokedex[079] = {name="Slowpoke",   type1="water",    type2="psychic",  rby_icon="biped"}
pokedex[080] = {name="Slowbro",    type1="water",    type2="psychic",  rby_icon="biped"}
pokedex[081] = {name="Magnemite",  type1="electric", type2=nil,        rby_icon="ball"}
pokedex[082] = {name="Magneton",   type1="electric", type2=nil,        rby_icon="ball"}
pokedex[083] = {name="Farfetch'd", type1="normal",   type2="flying",   rby_icon="bird"}
pokedex[084] = {name="Doduo",      type1="normal",   type2="flying",   rby_icon="bird"}
pokedex[085] = {name="Dodrio",     type1="normal",   type2="flying",   rby_icon="bird"}
pokedex[086] = {name="Seel",       type1="water",    type2=nil,        rby_icon="water"}
pokedex[087] = {name="Dewgong",    type1="water",    type2=nil,        rby_icon="water"}
pokedex[088] = {name="Grimer",     type1="poison",   type2=nil,        rby_icon="biped"}
pokedex[089] = {name="Muk",        type1="poison",   type2=nil,        rby_icon="biped"}
pokedex[090] = {name="Shellder",   type1="water",    type2=nil,        rby_icon="fossil"}
pokedex[091] = {name="Cloyster",   type1="water",    type2="ice",      rby_icon="fossil"}
pokedex[092] = {name="Gastly",     type1="ghost",    type2="poison",   rby_icon="biped"}
pokedex[093] = {name="Haunter",    type1="ghost",    type2="poison",   rby_icon="biped"}
pokedex[094] = {name="Gengar",     type1="ghost",    type2="poison",   rby_icon="biped"}
pokedex[095] = {name="Onix",       type1="rock",     type2="ground",   rby_icon="snake"}
pokedex[096] = {name="Drowzee",    type1="psychic",  type2=nil,        rby_icon="biped"}
pokedex[097] = {name="Hypno",      type1="psychic",  type2=nil,        rby_icon="biped"}
pokedex[098] = {name="Krabby",     type1="water",    type2=nil,        rby_icon="water"}
pokedex[099] = {name="Kingler",    type1="water",    type2=nil,        rby_icon="water"}
pokedex[100] = {name="Voltorb",    type1="electric", type2=nil,        rby_icon="ball"}
pokedex[101] = {name="Electrode",  type1="electric", type2=nil,        rby_icon="ball"}
pokedex[102] = {name="Exeggcute",  type1="grass",    type2="psychic",  rby_icon="plant"}
pokedex[103] = {name="Exeggutor",  type1="grass",    type2="psychic",  rby_icon="plant"}
pokedex[104] = {name="Cubone",     type1="ground",   type2=nil,        rby_icon="biped"}
pokedex[105] = {name="Marowak",    type1="ground",   type2=nil,        rby_icon="biped"}
pokedex[106] = {name="Hitmonlee",  type1="fighting", type2=nil,        rby_icon="biped"}
pokedex[107] = {name="Hitmonchan", type1="fighting", type2=nil,        rby_icon="biped"}
pokedex[108] = {name="Lickitung",  type1="normal",   type2=nil,        rby_icon="biped"}
pokedex[109] = {name="Koffing",    type1="poison",   type2=nil,        rby_icon="biped"}
pokedex[110] = {name="Weezing",    type1="poison",   type2=nil,        rby_icon="biped"}
pokedex[111] = {name="Rhyhorn",    type1="ground",   type2="rock",     rby_icon="quadruped"}
pokedex[112] = {name="Rhydon",     type1="ground",   type2="rock",     rby_icon="quadruped"}
pokedex[113] = {name="Chansey",    type1="normal",   type2=nil,        rby_icon="fairy"}
pokedex[114] = {name="Tangela",    type1="grass",    type2=nil,        rby_icon="plant"}
pokedex[115] = {name="Kangaskhan", type1="normal",   type2=nil,        rby_icon="biped"}
pokedex[116] = {name="Horsea",     type1="water",    type2=nil,        rby_icon="water"}
pokedex[117] = {name="Seadra",     type1="water",    type2=nil,        rby_icon="water"}
pokedex[118] = {name="Goldeen",    type1="water",    type2=nil,        rby_icon="water"}
pokedex[119] = {name="Seaking",    type1="water",    type2=nil,        rby_icon="water"}
pokedex[120] = {name="Staryu",     type1="water",    type2=nil,        rby_icon="fossil"}
pokedex[121] = {name="Starmie",    type1="water",    type2="psychic",  rby_icon="fossil"}
pokedex[122] = {name="Mr. Mime",   type1="psychic",  type2=nil,        rby_icon="biped"}
pokedex[123] = {name="Scyther",    type1="bug",      type2="flying",   rby_icon="insect"}
pokedex[124] = {name="Jynx",       type1="ice",      type2="ice",      rby_icon="biped"}
pokedex[125] = {name="Electabuzz", type1="electric", type2=nil,        rby_icon="biped"}
pokedex[126] = {name="Magmar",     type1="fire",     type2=nil,        rby_icon="biped"}
pokedex[127] = {name="Pinsir",     type1="bug",      type2=nil,        rby_icon="insect"}
pokedex[128] = {name="Tauros",     type1="normal",   type2=nil,        rby_icon="quadruped"}
pokedex[129] = {name="Magikarp",   type1="water",    type2=nil,        rby_icon="water"}
pokedex[130] = {name="Gyarados",   type1="water",    type2="flying",   rby_icon="snake"}
pokedex[131] = {name="Lapras",     type1="water",    type2="ice",      rby_icon="water"}
pokedex[132] = {name="Ditto",      type1="normal",   type2=nil,        rby_icon="biped"}
pokedex[133] = {name="Eevee",      type1="normal",   type2=nil,        rby_icon="quadruped"}
pokedex[134] = {name="Vaporeon",   type1="water",    type2=nil,        rby_icon="quadruped"}
pokedex[135] = {name="Jolteon",    type1="electric", type2=nil,        rby_icon="quadruped"}
pokedex[136] = {name="Flareon",    type1="fire",     type2=nil,        rby_icon="quadruped"}
pokedex[137] = {name="Porygon",    type1="normal",   type2=nil,        rby_icon="biped"}
pokedex[138] = {name="Omanyte",    type1="rock",     type2="water",    rby_icon="fossil"}
pokedex[139] = {name="Omastar",    type1="rock",     type2="water",    rby_icon="fossil"}
pokedex[140] = {name="Kabuto",     type1="rock",     type2="water",    rby_icon="fossil"}
pokedex[141] = {name="Kabutops",   type1="rock",     type2="water",    rby_icon="fossil"}
pokedex[142] = {name="Aerodactyl", type1="rock",     type2="flying",   rby_icon="bird"}
pokedex[143] = {name="Snorlax",    type1="normal",   type2=nil,        rby_icon="biped"}
pokedex[144] = {name="Articuno",   type1="ice",      type2="flying",   rby_icon="bird"}
pokedex[145] = {name="Zapdos",     type1="electric", type2="flying",   rby_icon="bird"}
pokedex[146] = {name="Moltres",    type1="fire",     type2="flying",   rby_icon="bird"}
pokedex[147] = {name="Dratini",    type1="dragon",   type2=nil,        rby_icon="snake"}
pokedex[148] = {name="Dragonair",  type1="dragon",   type2=nil,        rby_icon="snake"}
pokedex[149] = {name="Dragonite",  type1="dragon",   type2="flying",   rby_icon="snake"}
pokedex[150] = {name="Mewtwo",     type1="psychic",  type2=nil,        rby_icon="biped"}
pokedex[151] = {name="Mew",        type1="psychic",  type2=nil,        rby_icon="biped"}

return pokedex
