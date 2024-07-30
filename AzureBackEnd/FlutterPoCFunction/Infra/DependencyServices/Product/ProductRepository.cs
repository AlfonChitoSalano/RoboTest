using ApiPoC.Entities;
using System;
using System.Collections.Generic;
using System.Linq;

namespace ApiPoC.Infra
{
    public class ProductRepository : IProductRepository
    {
        public List<Category> GetAllCategoriesWithProducts()
        {
            var categories = GetListOfProductCategories();
            var products = GetProducts().ToList();

            if (!products.Any())
            {
                return categories;
            }

            foreach (var category in categories)
            {
                category.Products = products.Where(product =>
                    string.Equals(product.Category, category.Name, StringComparison.CurrentCultureIgnoreCase)).ToList();
            }

            return categories;
        }

        public List<Category> GetListOfProductCategories()
        {
            var productCategories =
                Environment.GetEnvironmentVariable("GetListOfProductCategories", EnvironmentVariableTarget.Process);

            if (productCategories == null)
            {
                throw new NullReferenceException(
                    "Please put the categories in the environment variable local settings in azure config");
            }

            var formatProductCategories = productCategories.Split(new[] { ',' }, StringSplitOptions.RemoveEmptyEntries)
                .Select((category, index) => new Category
                    { Name = category.Trim(), NumberEquivalent = (index + 1).ToString() })
                .ToList();
            return formatProductCategories;
        }

        public IEnumerable<Product> GetProductsByCategory(string category)
        {
            var products = GetProducts();
            return products.Where(product =>
                string.Equals(product.Category, category, StringComparison.CurrentCultureIgnoreCase));
        }

        // Products dummy data
        private static IEnumerable<Product> GetProducts()
        {
            return new List<Product>
            {
                new()
                {
                    Name = "Barong Tagalog",
                    Category = "Formal",
                    ImageUrl =
                        "https://firebasestorage.googleapis.com/v0/b/closetapp-c815a.appspot.com/o/_todelchange%2Fformal-barongtagalog.png?alt=media&token=4dd289a8-73b5-4005-b1d9-4957ca8690e2",
                    NumberEquivalent = "11"
                },
                new()
                {
                    Name = "White Tuxedo",
                    Category = "Formal",
                    ImageUrl =
                        "https://firebasestorage.googleapis.com/v0/b/closetapp-c815a.appspot.com/o/_todelchange%2Fformal-tuxedo.png?alt=media&token=db678243-7686-4ae8-ab8b-a8394b8035c0",
                    NumberEquivalent = "12"
                },
                new()
                {
                    Name = "Philippine Long Dress",
                    Category = "Formal",
                    ImageUrl =
                        "https://firebasestorage.googleapis.com/v0/b/closetapp-c815a.appspot.com/o/_todelchange%2Fformal-longdress.png?alt=media&token=c3b06e54-d993-4cc7-909a-6674c7479dd8",
                    NumberEquivalent = "13"
                },              
                new()
                {
                    Name = "Flower Dress",
                    Category = "Casual",
                    ImageUrl =
                        "https://firebasestorage.googleapis.com/v0/b/closetapp-c815a.appspot.com/o/_todelchange%2Fcasual-flowerdress.png?alt=media&token=90a130d6-d570-4dec-8ea6-1007f2f35122",
                    NumberEquivalent = "18"
                },
                new()
                {
                    Name = "Leather Jacket",
                    Category = "Casual",
                    ImageUrl =
                        "https://firebasestorage.googleapis.com/v0/b/closetapp-c815a.appspot.com/o/_todelchange%2Fcasual-leather.png?alt=media&token=6cee3dc3-521e-4d61-b9ca-4150e2caf018",
                    NumberEquivalent = "19"
                },
                new()
                {
                    Name = "Raffle Shirt with Black Pants",
                    Category = "Casual",
                    ImageUrl =
                        "https://firebasestorage.googleapis.com/v0/b/closetapp-c815a.appspot.com/o/_todelchange%2Fcasual-raffle.png?alt=media&token=b75f8e7b-51a3-41ff-94a2-07d21f2d121e",
                    NumberEquivalent = "20"
                },
                new()
                {
                    Name = "Red Dress",
                    Category = "Evening Wear",
                    ImageUrl =
                        "https://firebasestorage.googleapis.com/v0/b/closetapp-c815a.appspot.com/o/_todelchange%2Feve-reddress.png?alt=media&token=2f183317-0e3b-45a1-a3b8-1c629a2dbdb9",
                    NumberEquivalent = "22"
                },
                new()
                {
                    Name = "Suit",
                    Category = "Evening Wear",
                    ImageUrl =
                        "https://firebasestorage.googleapis.com/v0/b/closetapp-c815a.appspot.com/o/_todelchange%2Feve-suit.png?alt=media&token=1ffe0a4f-f2d3-4384-8bbd-5733f4364897",
                    NumberEquivalent = "23"
                },
                new()
                {
                    Name = "Long Gown",
                    Category = "Evening Wear",
                    ImageUrl =
                        "https://firebasestorage.googleapis.com/v0/b/closetapp-c815a.appspot.com/o/_todelchange%2Feve-gown.png?alt=media&token=30830aea-3659-48d3-97fa-20cfd6463ee7",
                    NumberEquivalent = "24"
                },              
                new()
                {
                    Name = "Karate Uniform",
                    Category = "Sports",
                    ImageUrl =
                        "https://firebasestorage.googleapis.com/v0/b/closetapp-c815a.appspot.com/o/_todelchange%2Fsports-karate.png?alt=media&token=981c8ba9-82c7-4326-b84d-26bc3eb7aafb",
                    NumberEquivalent = "26"
                },
                new()
                {
                    Name = "Badminton",
                    Category = "Sports",
                    ImageUrl =
                        "https://firebasestorage.googleapis.com/v0/b/closetapp-c815a.appspot.com/o/_todelchange%2Fsports-badminton.png?alt=media&token=a7aaea67-7013-41ed-b00b-1add5a436dfe",
                    NumberEquivalent = "27"
                },
                new()
                {
                    Name = "Soccer",
                    Category = "Sports",
                    ImageUrl =
                        "https://firebasestorage.googleapis.com/v0/b/closetapp-c815a.appspot.com/o/_todelchange%2Fsports-soccer.png?alt=media&token=35ca5dfc-0019-4d76-aa87-48a246dad3f9",
                    NumberEquivalent = "28"
                },
                //intentionally comment out to be null in FE
                //new()
                //{
                //    Name = "Sports 1",
                //    Category = "Sports",
                //    ImageUrl = 
                //        "https://firebasestorage.googleapis.com/v0/b/closetapp-c815a.appspot.com/o/sports%2Fsports1.jpg?alt=media&token=00ff60bf-e429-47ff-a109-efc416c4bd32",
                //    NumberEquivalent = "30"
                //},
                //new()
                //{
                //    Name = "Sports 2",
                //    Category = "Sports",
                //    ImageUrl = 
                //        "https://firebasestorage.googleapis.com/v0/b/closetapp-c815a.appspot.com/o/sports%2Fsports2.jpg?alt=media&token=e16a570b-339a-4840-ba3d-e52ef1a64e1b",
                //    NumberEquivalent = "31"
                //},
                //new()
                //{
                //    Name = "Sports 3",
                //    Category = "Sports",
                //    ImageUrl =
                //        "https://firebasestorage.googleapis.com/v0/b/closetapp-c815a.appspot.com/o/sports%2Fsports3.png?alt=media&token=928a2da1-9e01-405b-b117-d9bed091928b",
                //    NumberEquivalent = "32"
                //},
                //new()
                //{
                //    Name = "Sports 4",
                //    Category = "Sports",
                //    ImageUrl =
                //        "https://firebasestorage.googleapis.com/v0/b/closetapp-c815a.appspot.com/o/sports%2Fsports4.png?alt=media&token=d83efb3c-83be-4b57-a875-6db478b56c57",
                //    NumberEquivalent = "33"
                //}
            };
        }
    }
}