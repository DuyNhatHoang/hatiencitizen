import 'package:ha_tien_app/src/repositories/models/auth/login.dart';
import 'package:ha_tien_app/src/repositories/models/auth/session.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  String _accessTokenKey = "access_token";
  String _expiresInKey = "expires_in";
  String _authorizeDayKey = "expires_day";
  String _fullNameKey = "fullname";
  String _usernameKey = "username";
  String _passwordKey = "password";
  String _phoneNumberKey = "phoneNumber";
  String _emailKey = "email";
  String _phoneAddressKey = "phoneAddress";
  String _rolesKey = "roles";
  String _idKey = "id";

  // obtain shared preferences
  SharedPreferences prefs;

  SessionManager(this.prefs);

  createSession(Session session) async {
    prefs.setString(_accessTokenKey, session.accessToken);
    prefs.setInt(_expiresInKey, session.expiresIn);
    prefs.setString(_authorizeDayKey, session.authorizeDate);
    prefs.setString(_fullNameKey, session.fullName);
    prefs.setString(_usernameKey, session.userName);
    prefs.setString(_passwordKey, session.password);
    prefs.setString(_phoneNumberKey, session.phoneNumber);
    prefs.setString(_emailKey, session.email);
    prefs.setString(_phoneAddressKey, session.phoneAddress);
    prefs.setString(_rolesKey, session.roles);
    prefs.setString(_idKey, session.id);
  }

  Session getSession() => prefs.getString(_accessTokenKey) == null
      ? null
      : Session(
          accessToken: prefs.getString(_accessTokenKey) ?? "",
          expiresIn: prefs.getInt(_expiresInKey) ?? -1,
          fullName: prefs.getString(_fullNameKey) ?? "",
          userName: prefs.getString(_usernameKey) ?? "",
          password: prefs.getString(_passwordKey) ?? "",
          email: prefs.getString(_emailKey) ?? "",
          phoneNumber: prefs.getString(_phoneNumberKey) ?? "",
          phoneAddress: prefs.getString(_phoneAddressKey) ?? "",
          roles: prefs.getString(_rolesKey) ?? "",
          id: prefs.getString(_idKey) ?? "",
          authorizeDate: prefs.getString(_authorizeDayKey) ?? "",
        );

  removeSession() {
    prefs.remove(_accessTokenKey);
    prefs.remove(_expiresInKey);
    prefs.remove(_fullNameKey);
    prefs.remove(_usernameKey);
    prefs.remove(_passwordKey);
    prefs.remove(_phoneNumberKey);
    prefs.remove(_phoneAddressKey);
    prefs.remove(_emailKey);
    prefs.remove(_rolesKey);
    prefs.remove(_idKey);
    prefs.remove(_authorizeDayKey);
  }
}
