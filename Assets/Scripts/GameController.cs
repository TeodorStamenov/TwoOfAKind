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

    public List<int> pairs;

    private bool firstGuess;
    private bool secondGuess;

    private int selectedFirstButtonIndex;
    private int selectedSecondButtonIndex;

    private int firstPairIndex;
    private int secondPairIndex;

    private int countCorrectGuesses;
    private int gameGuesses;
    private int countAllGuesses;


    void Awake()
    {
        imagesPool = Resources.LoadAll<Sprite>("Sprites/Landscapes");
    }

    void Start()
    {
        InitializeButtons();
        InitializeButtonListeners();
        InitializePairs();

        gameGuesses = buttons.Count / 2;
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

        if (!firstGuess)
        {    
            selectedFirstButtonIndex = int.Parse(name);
            
            firstGuess = true;
            firstPairIndex = pairs[selectedFirstButtonIndex];

            UnityEngine.UI.Button selectedButton = buttons[selectedFirstButtonIndex];
            Transform hiddenImage = selectedButton.gameObject.transform.Find("HiddenImage");
            UnityEngine.UI.Image image = hiddenImage.GetComponent<UnityEngine.UI.Image>();

            image.enabled = true;
        }
        else if(!secondGuess)
        {
            selectedSecondButtonIndex = int.Parse(name);

            secondGuess = true;
            secondPairIndex = pairs[selectedSecondButtonIndex];

            UnityEngine.UI.Button selectedButton = buttons[selectedSecondButtonIndex];
            Transform hiddenImage = selectedButton.gameObject.transform.Find("HiddenImage");
            UnityEngine.UI.Image image = hiddenImage.GetComponent<UnityEngine.UI.Image>();

            image.enabled = true;
            
            StartCoroutine(CheckIfPairMatch());
        }
    }

    IEnumerator CheckIfPairMatch()
    {
        yield return new WaitForSeconds(1f);

        if (firstPairIndex == secondPairIndex)
        {
            yield return new WaitForSeconds(.5f);

            buttons[selectedFirstButtonIndex].interactable = false;
            buttons[selectedSecondButtonIndex].interactable = false;

            buttons[selectedFirstButtonIndex].GetComponent<CanvasGroup>().alpha = 0;
            buttons[selectedFirstButtonIndex].GetComponent<CanvasGroup>().interactable = false;

            buttons[selectedSecondButtonIndex].GetComponent<CanvasGroup>().alpha = 0;
            buttons[selectedSecondButtonIndex].GetComponent<CanvasGroup>().interactable = false;

            // Transform hiddenImage = buttons[selectedFirstButtonIndex].gameObject.transform.Find("HiddenImage");
            // buttons[selectedFirstButtonIndex].GetComponent<UnityEngine.UI.Image>().enabled = false;
            // hiddenImage.GetComponent<UnityEngine.UI.Image>().enabled = false;
            
            // hiddenImage = buttons[selectedSecondButtonIndex].gameObject.transform.Find("HiddenImage");
            // buttons[selectedSecondButtonIndex].GetComponent<UnityEngine.UI.Image>().enabled = false;
            // hiddenImage.GetComponent<UnityEngine.UI.Image>().enabled = false;
            
            CheckIfTheGameIsFinished();
        }
    }

    void CheckIfTheGameIsFinished()
    {
        countCorrectGuesses++;

        if (countCorrectGuesses == gameGuesses)
        {
            Debug.Log("Game finished");
        }
    }

    void InitializePairs()
    {
        List<int> indices = Enumerable.Range(0, imagesPool.Length).ToList();
        indices = indices.OrderBy(i => UnityEngine.Random.value).ToList();

        pairs = indices.GetRange(0, buttons.Count / 2);
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
