using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using Unity.VisualScripting;
using UnityEditor.UIElements;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.UIElements;

public class GameController : MonoBehaviour
{
    public List<UnityEngine.UI.Button> buttons = new List<UnityEngine.UI.Button>();

    public Sprite[] imagesPool;

    public List<Sprite> listOfPairs = new List<Sprite>();

    void Awake()
    {
        imagesPool = Resources.LoadAll<Sprite>("Sprites/Landscapes");
    }

    void Start()
    {
        InitializeButtons();
        InitializeButtonListeners();
        InitializePairs();
    }

    void InitializeButtons()
    {
        GameObject[] objects = GameObject.FindGameObjectsWithTag("FieldButtonTag");

        for (int i = 0; i < objects.Length; i++)
        {
            buttons.Add(objects[i].GetComponent<UnityEngine.UI.Button>());
        }
    }

    void InitializeButtonListeners()
    {
        foreach(UnityEngine.UI.Button btn in buttons)
        {
            btn.onClick.AddListener(()=>ButtonEventHandler());
        }
    }

    public void ButtonEventHandler()
    {
        string name = UnityEngine.EventSystems.EventSystem.current.currentSelectedGameObject.name;
        Debug.Log("You are clicking a button named: " + name);
    }

    void InitializePairs()
    {
        List<int> indices = Enumerable.Range(0, imagesPool.Length).ToList();
        indices = indices.OrderBy(i => UnityEngine.Random.value).ToList();

        List<int> pairs = indices.GetRange(0, buttons.Count / 2);
        pairs.AddRange(pairs);
        pairs = pairs.OrderBy(i => UnityEngine.Random.value).ToList();
        
        for (int index = 0; index < buttons.Count; index++)
        {
            int imageIndex = pairs[index];

            UnityEngine.UI.Button btn = buttons[index];
            Sprite imageSource = imagesPool[imageIndex];

            Transform hiddenImage = btn.gameObject.transform.Find("HiddenImage");
            UnityEngine.UI.Image image = hiddenImage.GetComponent<UnityEngine.UI.Image>();
            image.sprite = imageSource;
            image.enabled = false;
        }
    }

}
