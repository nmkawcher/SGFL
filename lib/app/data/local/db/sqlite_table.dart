

const String tableUser = 'user';
const String tableOrganization ='organization';
const String tableProduct = 'product';
const String tableDepot = 'depot';
const String tableDepotZone = 'depot_zone';


const String userDBTable = '''CREATE TABLE $tableUser (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    designation TEXT NULL,
    email TEXT NULL,
    phone_no TEXT NULL,
    role TEXT NULL,
    avatar TEXT NULL
)''';

const String organisationDBTable = '''CREATE TABLE $tableOrganization (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    short_name TEXT NULL,
    address TEXT NULL,
    logo TEXT NULL
)''';

const String productDBTable = '''CREATE TABLE $tableProduct (
    id INTEGER PRIMARY KEY,
    name TEXT NULL,
    logo_text TEXT NULL,
    type TEXT NULL,
    price_bbl TEXT NULL,
    price_liter TEXT NULL,
    vat_liter TEXT NULL
)''';

const String depotDBTable = '''CREATE TABLE $tableDepot (
   CREATE TABLE depot (
    id INTEGER PRIMARY KEY,
    name TEXT NULL,
    shortName TEXT NULL,
    type TEXT NULL,
    category TEXT NULL,
    address TEXT NULL,
    logo TEXT NULL
)''';

const String depotZoneDBTable = '''CREATE TABLE $tableDepotZone (
  id INTEGER PRIMARY KEY,
    depotId INTEGER,
    name TEXT NULL,
    shortName TEXT NULL,
    postcode TEXT NULL,
    address TEXT NULL,
    logo TEXT NULL,
    FOREIGN KEY(depotId) REFERENCES depot(id)
)''';
