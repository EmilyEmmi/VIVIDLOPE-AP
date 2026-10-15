function uuid_random()
{
    static length = 256;
    static rnd = fill_random_bytes([], length);
    
    if (array_length(rnd) < length)
        fill_random_bytes(rnd, length);
    
    return rnd;
}
