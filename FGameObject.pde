
class FGameObject extends FBox



{
  final int L = -1;
  final int R = 1;
  FGameObject()


  {
    super(gridsize, gridsize);
  }
 boolean isTouching(String name) {
  ArrayList contacts = getContacts();

  for (int i = 0; i < contacts.size(); i++) {
    FContact c = (FContact) contacts.get(i);

    FBody other = c.getBody1();
    if (other == this) other = c.getBody2();

    if (other != null && name.equals(other.getName())) {
      return true;
    }
  }
  return false;
}

  void act() {
  }

  FGameObject(float w, float h) {
    super(w, h);
  }
}
