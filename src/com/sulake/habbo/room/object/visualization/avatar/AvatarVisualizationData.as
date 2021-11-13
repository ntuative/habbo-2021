package com.sulake.habbo.room.object.visualization.avatar
{
    import com.sulake.room.object.visualization.IRoomObjectVisualizationData;
    import com.sulake.habbo.avatar.IAvatarRenderManager;
    import com.sulake.habbo.avatar.IAvatarImage;
    import com.sulake.habbo.avatar.IAvatarImageListener;
    import com.sulake.habbo.avatar.IAvatarEffectListener;
    import com.sulake.core.assets.IAsset;

    public class AvatarVisualizationData implements IRoomObjectVisualizationData 
    {

        private var _avatarRenderer:IAvatarRenderManager = null;


        public function get avatarRenderer():IAvatarRenderManager
        {
            return (_avatarRenderer);
        }

        public function set avatarRenderer(_arg_1:IAvatarRenderManager):void
        {
            _avatarRenderer = _arg_1;
        }

        public function initialize(_arg_1:XML):Boolean
        {
            return (true);
        }

        public function dispose():void
        {
            _avatarRenderer = null;
        }

        public function getAvatar(_arg_1:String, _arg_2:Number, _arg_3:String=null, _arg_4:IAvatarImageListener=null, _arg_5:IAvatarEffectListener=null):IAvatarImage
        {
            var _local_6:IAvatarImage;
            if (_avatarRenderer != null)
            {
                _local_6 = null;
                if (_arg_2 > 48)
                {
                    _local_6 = _avatarRenderer.createAvatarImage(_arg_1, "h", _arg_3, _arg_4, _arg_5);
                }
                else
                {
                    _local_6 = _avatarRenderer.createAvatarImage(_arg_1, "h_50", _arg_3, _arg_4, _arg_5);
                };
                return (_local_6);
            };
            return (null);
        }

        public function getLayerCount(_arg_1:String):Number
        {
            return (0);
        }

        public function getAvatarRendererAsset(_arg_1:String):IAsset
        {
            if (_avatarRenderer == null)
            {
                return (null);
            };
            return (_avatarRenderer.assets.getAssetByName(_arg_1));
        }


    }
}