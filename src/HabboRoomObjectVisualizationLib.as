package 
{
    import mx.core.SimpleApplication;
    import com.sulake.bootstrap.RoomObjectVisualizationFactoryBootstrap;
    import com.sulake.iid.IIDRoomObjectVisualizationFactory;

        public class HabboRoomObjectVisualizationLib extends SimpleApplication 
    {

        public static var manifest:Class = HabboHabboRoomObjectVisualizationLib_Habbomanifest_xml;
        public static var pet_experience_bubble_png:Class = HabboHabboRoomObjectVisualizationLib_pet_experience_bubble_png;
        public static var snowball_small_png:Class = HabboHabboRoomObjectVisualizationLib_snowball_small_png;
        public static var snowball_small_shadow_png:Class = HabboHabboRoomObjectVisualizationLib_snowball_small_shadow_png;
        public static var snowball_big_png:Class = HabboHabboRoomObjectVisualizationLib_snowball_big_png;
        public static var snowball_splash_1:Class = HabboHabboRoomObjectVisualizationLib_Habbosnowball_splash_1_png;
        public static var snowball_splash_2:Class = HabboHabboRoomObjectVisualizationLib_Habbosnowball_splash_2_png;
        public static var snowball_splash_3:Class = HabboHabboRoomObjectVisualizationLib_Habbosnowball_splash_3_png;
        public static var requiredClasses:Array = new Array(RoomObjectVisualizationFactoryBootstrap, IIDRoomObjectVisualizationFactory);


    }
}