using System;
using System.Drawing.Imaging;
using System.IO;
using NetBarcode;
using Type = NetBarcode.Type;

namespace ConsoleApp2
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.ReadKey();
            for (int i = 0; i < 5000; i++)
            {
                Barcode bar = new Barcode("123456789123456", Type.Code128);
                using (var image = bar.GetImage())
                {
                    using (MemoryStream ms = new MemoryStream())
                    {
                        image.Save(ms,ImageFormat.Png);
                        var base64 = Convert.ToBase64String(ms.ToArray());
                        Console.WriteLine(i);
                    }
                }
            }
            Console.ReadKey();
            Console.ReadKey();
        }
    }
}
