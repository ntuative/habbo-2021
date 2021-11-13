package login
{
    import onBoardingHcUi.IUIContext;
    import com.sulake.habbo.communication.login.AvatarData;

    public /*dynamic*/ interface ILoginContext extends IUIContext 
    {

        function initLogin(_arg_1:String, _arg_2:String):void;
        function initLoginWithSsoToken(_arg_1:String, _arg_2:String):void;
        function loginWithAvatar(_arg_1:AvatarData):void;
        function showScreen(_arg_1:int):void;

    }
}