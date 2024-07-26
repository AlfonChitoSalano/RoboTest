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
                        "https://firebasestorage.googleapis.com/v0/b/closetapp-c815a.appspot.com/o/_todelchange%2Fformal-barongtagalog.png?alt=media&token=0ad0c92f-1f67-4733-8b35-e4a3b702b6d9",
                    NumberEquivalent = "11"
                },
                new()
                {
                    Name = "School Uniform Boys",
                    Category = "Formal",
                    ImageUrl =
                        "https://firebasestorage.googleapis.com/v0/b/closetapp-c815a.appspot.com/o/_todelchange%2Fformal-boysuniform.png?alt=media&token=df3f6604-6867-4597-9874-f2f48d181912",
                    NumberEquivalent = "12"
                },
                new()
                {
                    Name = "School Uniform Girls",
                    Category = "Formal",
                    ImageUrl =
                        "https://firebasestorage.googleapis.com/v0/b/closetapp-c815a.appspot.com/o/_todelchange%2Fformal-schooluniform.png?alt=media&token=612ceeb9-88c2-4228-ad0f-7c18c817e593",
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
                    Name = "Black Dress",
                    Category = "Casual",
                    ImageUrl =
                        "https://firebasestorage.googleapis.com/v0/b/closetapp-c815a.appspot.com/o/_todelchange%2Fcasual-blackdress.png?alt=media&token=f9d9aeb7-76a2-4d8e-aeb4-a841cdbb2b79",
                    NumberEquivalent = "19"
                },
                new()
                {
                    Name = "Pink Dress",
                    Category = "Casual",
                    ImageUrl =
                        "https://firebasestorage.googleapis.com/v0/b/closetapp-c815a.appspot.com/o/wedding%2Fwedding3.png?alt=media&token=5f9205e8-692d-4923-99c8-3f42c3218e0b",
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
                    Name = "White Dress",
                    Category = "Evening Wear",
                    ImageUrl =
                        "https://firebasestorage.googleapis.com/v0/b/closetapp-c815a.appspot.com/o/_todelchange%2Feve-whitedress.png?alt=media&token=119fe74c-8290-4f17-b9b0-a39afb08310f",
                    NumberEquivalent = "23"
                },
                new()
                {
                    Name = "Monochrome Dress",
                    Category = "Evening Wear",
                    ImageUrl =
                        "https://firebasestorage.googleapis.com/v0/b/closetapp-c815a.appspot.com/o/business%2Fbusiness3.png?alt=media&token=a3c634e3-8d9b-4d56-87d5-289fe558eaf4",
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
                    Name = "Badminton Uniform",
                    Category = "Sports",
                    ImageUrl =
                        "https://firebasestorage.googleapis.com/v0/b/closetapp-c815a.appspot.com/o/_todelchange%2Fsports-sportshirt.png?alt=media&token=c74e46c5-b497-4513-bdc3-0fd552bf9187",
                    NumberEquivalent = "27"
                },
                new()
                {
                    Name = "Soccer Uniform",
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