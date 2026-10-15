function generate_uuidv4(arg0)
{
    var seed = undefined == arg0;
    var bytes = array_create(16);
    array_copy(bytes, 0, uuid_random(), 0, 16);
    array_delete(uuid_random(), 0, 16);
    bytes[6] = (bytes[6] & 15) | 64;
    bytes[8] = (bytes[8] & 63) | 128;
    return stringify_uuid(bytes);
}
