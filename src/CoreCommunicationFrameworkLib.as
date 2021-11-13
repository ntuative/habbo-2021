package 
{
    import mx.core.SimpleApplication;
    import com.sulake.bootstrap.CoreCommunicationManagerBootstrap;
    import com.sulake.iid.IIDCoreCommunicationManager;

        public class CoreCommunicationFrameworkLib extends SimpleApplication 
    {

        public static var manifest:Class = HabboCoreCommunicationFrameworkLib_Habbomanifest_xml;
        public static var requiredClasses:Array = new Array(CoreCommunicationManagerBootstrap, IIDCoreCommunicationManager);


    }
}