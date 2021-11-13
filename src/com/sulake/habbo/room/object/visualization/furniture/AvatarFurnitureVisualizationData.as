package com.sulake.habbo.room.object.visualization.furniture
{
    import com.sulake.habbo.room.object.visualization.avatar.AvatarVisualizationData;
    import com.sulake.habbo.avatar.IAvatarRenderManager;
    import com.sulake.habbo.avatar.IAvatarImageListener;
    import com.sulake.habbo.avatar.IAvatarEffectListener;
    import com.sulake.habbo.avatar.IAvatarImage;

    public class AvatarFurnitureVisualizationData extends FurnitureVisualizationData 
    {

        private var _SafeStr_3294:AvatarVisualizationData;

        public function AvatarFurnitureVisualizationData()
        {
            _SafeStr_3294 = new AvatarVisualizationData();
        }

        public function set avatarRenderer(_arg_1:IAvatarRenderManager):void
        {
            _SafeStr_3294.avatarRenderer = _arg_1;
        }

        override public function dispose():void
        {
            super.dispose();
            _SafeStr_3294.dispose();
            _SafeStr_3294 = null;
        }

        public function getAvatar(_arg_1:String, _arg_2:Number, _arg_3:String=null, _arg_4:IAvatarImageListener=null, _arg_5:IAvatarEffectListener=null):IAvatarImage
        {
            return (_SafeStr_3294.getAvatar(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5));
        }


    }
}

