# Detect whether a secrets collection is available and unlocked

import dbus
import argparse
import sys

SECRETS_NAME = "org.freedesktop.secrets"
SECRETS_PATH = "/org/freedesktop/secrets"

def main():
    parser = argparse.ArgumentParser(description='Detect whether a secrets collection is available and unlocked')
    parser.add_argument('collection', type=str, nargs='?',
            help='The collection name to check [Default: autodetect]')
    parser.add_argument('-V', '--verbose', action='store_true',
            help='Be verbose')

    args = parser.parse_args()

    ##############################
    session_bus = dbus.SessionBus()

    #if not session_bus.name_has_owner(SECRETS_NAME):
    #    raise ValueError

    secrets_obj = session_bus.get_object(SECRETS_NAME, SECRETS_PATH)
    collections = secrets_obj.Get("org.freedesktop.Secret.Service", 'Collections', dbus_interface='org.freedesktop.DBus.Properties')

    if not collections:
        raise ValueError("No secret service Collections found")

    if args.verbose:
        print(f"Detected Collections:")
        print('\n'.join(collections))

    collection = str(collections[0])

    if args.collection:
        if (args.collection in collections):
            collection = args.collection
        else:
            raise ValueError(f"Bad collection: {args.collection}")

    if args.verbose:
        print(f"Checking Collection \"{collection}\"")

    collection_obj = session_bus.get_object(SECRETS_NAME, collection)

    locked = bool(collection_obj.Get("org.freedesktop.Secret.Collection", 'Locked', dbus_interface='org.freedesktop.DBus.Properties'))
    if args.verbose:
        print(f"Collection \"{collection}\" is {'locked' if locked else 'unlocked'}")

    return locked

if __name__ == '__main__':
    main()
