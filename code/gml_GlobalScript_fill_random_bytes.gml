function fill_random_bytes(arg0, arg1)
{
    var num = arg1;
    var arr = arg0;
    var i = array_length(arr);
    
    while (i < num)
    {
        array_push(arr, irandom_range(0, 255));
        i++;
    }
    
    return arr;
}
