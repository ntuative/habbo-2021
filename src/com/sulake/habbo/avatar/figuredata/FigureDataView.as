package com.sulake.habbo.avatar.figuredata
{
    import com.sulake.habbo.avatar.IAvatarImageListener;
    import com.sulake.habbo.window.widgets.IRoomPreviewerWidget;
    import com.sulake.habbo.room.preview.RoomPreviewer;
    import com.sulake.habbo.avatar.IAvatarImage;

    public class FigureDataView implements IAvatarImageListener 
    {

        public static const PREVIEW_AVATAR_DIRECTION:int = 4;

        private var _SafeStr_1324:IRoomPreviewerWidget;
        private var _SafeStr_515:RoomPreviewer;
        private var _SafeStr_1275:FigureData;
        private var _figureString:String;
        private var _disposed:Boolean;

        public function FigureDataView(_arg_1:FigureData)
        {
            _SafeStr_1275 = _arg_1;
            _SafeStr_1324 = (_arg_1.avatarEditor.view.getFigureContainer().widget as IRoomPreviewerWidget);
            _SafeStr_515 = _SafeStr_1324.roomPreviewer;
            _SafeStr_515.updateRoomWallsAndFloorVisibility(false, false);
        }

        public function update(_arg_1:String, _arg_2:int=0, _arg_3:int=4):void
        {
            var _local_4:IAvatarImage;
            _figureString = _arg_1;
            if (_SafeStr_515.isRoomEngineReady)
            {
                _SafeStr_515.addAvatarIntoRoom(_arg_1, _arg_2);
                _SafeStr_515.updateAvatarDirection(_arg_3, _arg_3);
                _SafeStr_515.updatePreviewRoomView(true);
                _SafeStr_515.updateRoomEngine();
            }
            else
            {
                _local_4 = _SafeStr_1275.avatarEditor.manager.avatarRenderManager.createAvatarImage(_arg_1, "h", null, this);
                _SafeStr_1324.showPreview(_local_4.getCroppedImage("full"));
            };
        }

        public function avatarImageReady(_arg_1:String):void
        {
            var _local_2:IAvatarImage;
            if (_arg_1 == _figureString)
            {
                _local_2 = _SafeStr_1275.avatarEditor.manager.avatarRenderManager.createAvatarImage(_arg_1, "h", null, this);
                _SafeStr_1324.showPreview(_local_2.getCroppedImage("full"));
            };
        }

        public function dispose():void
        {
            _disposed = true;
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }


    }
}

