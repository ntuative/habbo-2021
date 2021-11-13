package com.sulake.habbo.avatar.torso
{
    import com.sulake.habbo.avatar.common.CategoryBaseModel;
    import com.sulake.habbo.avatar.common.IAvatarEditorCategoryModel;
    import com.sulake.habbo.avatar.HabboAvatarEditor;

    public class TorsoModel extends CategoryBaseModel implements IAvatarEditorCategoryModel 
    {

        public function TorsoModel(_arg_1:HabboAvatarEditor)
        {
            super(_arg_1);
        }

        override protected function init():void
        {
            super.init();
            initCategory("cc");
            initCategory("ch");
            initCategory("ca");
            initCategory("cp");
            _SafeStr_573 = true;
            if (!_SafeStr_570)
            {
                _SafeStr_570 = new TorsoView(this);
                if (_SafeStr_570)
                {
                    _SafeStr_570.init();
                };
            };
        }


    }
}

