package com.sulake.habbo.friendbar
{
    import com.sulake.core.runtime.Component;
    import com.sulake.habbo.friendbar.data.HabboFriendBarData;
    import com.sulake.iid.IIDHabboFriendBarData;
    import com.sulake.habbo.friendbar.view.HabboFriendBarView;
    import com.sulake.iid.IIDHabboFriendBarView;
    import com.sulake.habbo.friendbar.landingview.HabboLandingView;
    import com.sulake.iid.IIDHabboLandingView;
    import com.sulake.habbo.friendbar.talent.HabboTalent;
    import com.sulake.iid.IIDHabboTalent;
    import com.sulake.habbo.friendbar.popup.HabboEpicPopupView;
    import com.sulake.iid.IIDHabboEpicPopupView;
    import com.sulake.habbo.friendbar.groupforums.GroupForumController;
    import com.sulake.iid.IIDHabboGroupForumController;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.friendbar.view.IHabboFriendBarView;

    public class HabboFriendBar extends Component implements IHabboFriendBar 
    {

        public function HabboFriendBar(_arg_1:IContext, _arg_2:uint=0, _arg_3:IAssetLibrary=null)
        {
            super(_arg_1, _arg_2, _arg_3);
            _arg_1.attachComponent(new HabboFriendBarData(_arg_1, 0, _arg_3), [new IIDHabboFriendBarData()]);
            _arg_1.attachComponent(new HabboFriendBarView(_arg_1, 0, _arg_3), [new IIDHabboFriendBarView()]);
            _arg_1.attachComponent(new HabboLandingView(_arg_1, 0, _arg_3), [new IIDHabboLandingView()]);
            _arg_1.attachComponent(new HabboTalent(_arg_1, 0, _arg_3), [new IIDHabboTalent()]);
            _arg_1.attachComponent(new HabboEpicPopupView(_arg_1, 0, _arg_3), [new IIDHabboEpicPopupView()]);
            _arg_1.attachComponent(new GroupForumController(_arg_1, 0, _arg_3), [new IIDHabboGroupForumController()]);
        }

        public function set visible(_arg_1:Boolean):void
        {
            var _local_2:IHabboFriendBarView = (queueInterface(new IIDHabboFriendBarView()) as IHabboFriendBarView);
            if (_local_2 != null)
            {
                _local_2.visible = _arg_1;
                _local_2.release(new IIDHabboFriendBarView());
            };
        }


    }
}