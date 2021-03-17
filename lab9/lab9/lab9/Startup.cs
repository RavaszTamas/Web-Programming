using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(lab9.Startup))]
namespace lab9
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
