using UnityEngine;
using System.Collections;

public class AnimationBoolTriggering : MonoBehaviour {

	public Animator animator;
	private string doubleClick = "Idle";

	// Use this for initialization

	public void SetParameter (string TriggerToSet)
	{
		if (doubleClick != TriggerToSet) {

			animator.SetTrigger (TriggerToSet);
			doubleClick = TriggerToSet;
		}
	}


	void Start () {
			
		animator = GetComponent<Animator>();

	}
	
	// Update is called once per frame
	void Update () {

		//animator.SetBool("Idle", true);	

	}
}
