namespace Electronics_Shop_17.Services
{
    public class Class1
    {
        public int[] arr1 { get; set; }
        public int[] arr2 { get; set; }

        public int[] sortiraj(int[] obj)
        {
            for (int iii = 0; iii < obj.Length - 1; iii++)
            {
                for (int ii = 0; ii < obj.Length - 1; ii++)
                {
                    if (obj[ii] > obj[ii + 1])
                    {
                        var temp = obj[ii];
                        obj[ii] = obj[ii + 1];
                        obj[ii + 1] = temp;
                    }
                }
            }
            return obj;
        }
    }
}
